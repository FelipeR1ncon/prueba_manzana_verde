import 'package:flutter/material.dart';
import 'package:separate_api/service/service_interface.dart';
import 'model/cupon.dart';
import 'model/payment_summary.dart';
import 'model/producto.dart';

class CatalogCartAndCheckout extends ChangeNotifier {
  List<Product> products = [];
  int? sum;
  String? error;
  PaymentSummary? paymentSummary;

  final ServiceI _serviceI;

  CatalogCartAndCheckout(this._serviceI);

  init() async {
    await fetchProducts();
  }

  fetchProducts() async {
    var products = await _serviceI.getProducts();
    products = products["result"];
    this.products = (products as List).map(
      (e) {
        var product = Product.fromJson(e);
        product.selected = 0;
        return product;
      },
    ).toList();
    notifyListeners();
  }

  addProduct(Product product) {
    var productInList = products.firstWhere(
      (element) => element.id == product.id,
    );
    var count = products.where((element) => element.selected == 1);
    sum = count.length;
    productInList.selected = 1;
    productInList.quantity = (productInList.quantity) + 1;
    notifyListeners();
  }

  removeProduct(Product product) {
    product.quantity = product.quantity - 1;
    var count = products.where((element) => element.selected == 1);
    sum = count.length;
    notifyListeners();
  }

  checkPrices() {
    for (var i = 0; i < products.length; i++) {
      products[i].selected = 0;
      products[i].quantity = 0;
    }
  }

  calculateTotal() {
    double subTotalProduct = 0;
    double shippingCost = 0;

    ///Se clona la lista de productos con los agregados para no afectar
    ///la lista original
    List<Product> productsClone = [];
    for (var originalProduct in products) {
      if (originalProduct.quantity > 0) {
        productsClone.add(originalProduct.clone());
      }
    }


    ///Mapa para guardar los codigos de los productos a los que ya se les aplico
    ///un descuento por paquete, la key es el producto que tenia en sus match al
    ///codigo que esta como valor
    Map<int, int> productsWithDiscountsApplied = {};

    for (var currentProduct in productsClone) {
      bool match = false;

      ///Si el producto ya se le aplico un descuento es por que paso como paquete
      ///y por lo tanto su subtotal ya fue calculado
      if (!productsWithDiscountsApplied.containsKey(currentProduct.id) &&
          !productsWithDiscountsApplied.containsValue(currentProduct.id)) {
        ///Si el producto esta en promocion y esta por mas de 2 unidades se aplica
        ///la promocion de un producto gratis
        if (currentProduct.quantity > 2 && currentProduct.promotion) {
          currentProduct.quantity = currentProduct.quantity - 1;
        }

        ///Si no aplica para promocion verificamos si aplica a la promo por paquete
        else {
          /// Buscamos si el producto actual tiene algun id de los otros productos
          /// dentro de sus match
          if (currentProduct.match.isNotEmpty) {
            for (var idMatch in currentProduct.match) {
              for (var productPackage in productsClone) {
                if (productPackage.id != currentProduct.id &&
                    !productPackage.promotion &&
                    !currentProduct.promotion &&
                    !productsWithDiscountsApplied
                        .containsKey(productPackage.id) &&
                    !productsWithDiscountsApplied
                        .containsValue(productPackage.id)) {
                  if (idMatch == productPackage.id && !match) {
                    subTotalProduct = subTotalProduct +
                        (currentProduct.quantity.toDouble() *
                            (currentProduct.price * 0.90)) +
                        (productPackage.quantity *
                            (productPackage.price * 0.90));

                    productsWithDiscountsApplied[currentProduct.id] =
                        productPackage.id;
                    match = true;
                  }
                }
              }
            }
          }

          ///Buscamos si en lo otros productos tienen el id del producto actual
          ///en sus match
          ///
          ///Solo si el producto actual no hizo un paquete  con algun id de
          ///sus match
          if (!productsWithDiscountsApplied.containsKey(currentProduct.id) &&
              !match) {
            for (var productPackage in productsClone) {
              if (!productPackage.promotion &&
                  !currentProduct.promotion &&
                  productPackage.match.isNotEmpty &&
                  productPackage.id != currentProduct.id &&
                  !productsWithDiscountsApplied
                      .containsKey(productPackage.id) &&
                  !productsWithDiscountsApplied
                      .containsValue(productPackage.id)) {
                for (var code in productPackage.match) {
                  if (code == currentProduct.id && !match) {
                    subTotalProduct = subTotalProduct +
                        (currentProduct.quantity.toDouble() *
                            (currentProduct.price * 0.90)) +
                        (productPackage.quantity *
                            (productPackage.price * 0.90));

                    productsWithDiscountsApplied[productPackage.id] =
                        currentProduct.id;

                    match = true;
                  }
                }
              }
            }
          }
        }

        ///Si se  aplica un paquete el subtotal ya estara calculado
        if (!productsWithDiscountsApplied.containsValue(currentProduct.id) &&
            !productsWithDiscountsApplied.containsKey(currentProduct.id)) {
          subTotalProduct = subTotalProduct +
              currentProduct.quantity.toDouble() *
                  currentProduct.price.toDouble();
        }
      }
    }

    ///Si el suptotal NO es igual  o mayor a 500 se le cobra 30 de envio
    if (subTotalProduct < 500 && productsClone.isNotEmpty) {
      shippingCost = 30;
    }

    paymentSummary = PaymentSummary(subTotalProduct, shippingCost);
  }

  getCoupon(String code) async {
    error = null;
    var cupon = await _serviceI.getCoupon(code);
    cupon = cupon["result"];
    if (cupon != null) {
      paymentSummary!.coupon = Coupon.fromJson(cupon);
      notifyListeners();
    } else {
      error = "El cupón no existe";
      notifyListeners();
    }
  }

  clearCart() {
    for (var i = 0; i < products.length; i++) {
      products[i].selected = 0;
      products[i].quantity = 0;
    }
    notifyListeners();
  }

  pay(BuildContext context) {
    clearCart();
    paymentSummary != null;
    Navigator.of(context).pop();
  }

  void removeCoupon() {
    paymentSummary!.coupon = null;
    notifyListeners();
  }
}
