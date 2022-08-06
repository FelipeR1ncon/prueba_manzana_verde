import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:separate_api/app_controller.dart';
import 'package:separate_api/model/producto.dart';
import 'package:separate_api/service/service_interface.dart';
import 'package:http/http.dart' as http;

class MockService extends Mock implements ServiceI {}

void main() {
  late ServiceI serviceI;
  late CatalogCartAndCheckout catalogAndCheckout;
  const shippingCost = 30;
  const minimumFreeShipping = 500;

  final cuponFijo = {
    "id": 2,
    "code": "FIJO",
    "description": "100 de descuento en el total de tu compra",
    "type": "DISCOUNT_FIXED",
    "payload": {
      "value": 10,
      "minimum": 1000,
    },
  };

  final cuponPorcentaje = {
    "id": 1,
    "code": "PORCENTAJE",
    "description": "10% de descuento en el total de tu compra",
    "type": "DISCOUNT_PERCENTAGE",
    "payload": {
      "value": 10,
      "minimum": 700,
    },
  };

  setUp(() {
    serviceI = MockService();

    catalogAndCheckout = CatalogCartAndCheckout(serviceI);
  });

  test('Calcular total de 0 productos agregados', () {
    final products = {
      1: {
        "id": 1,
        "name": "Bolsa",
        "image": "bolsa",
        "promotion": false,
        "price": 300,
      }
    };
    http.Response res = http.Response(
      jsonEncode({
        "success": true,
        "message": "",
        "result": products.values.toList(),
      }),
      200,
    );

    when(() => serviceI.getProducts()).thenReturn(res);

    catalogAndCheckout.calculateTotal();

    expect(catalogAndCheckout.paymentSummary!.getTotal(), 0);
  });

  group('Calculos de 1 solo producto sin promocion', () {
    test('Con precio menor a 500 ', () {
      final productTest =
          Product(1, 1, "P1", "IM1", minimumFreeShipping - 1, 1, false, []);
      catalogAndCheckout.products = [productTest];

      catalogAndCheckout.calculateTotal();

      ///Verificar subtotal
      expect(catalogAndCheckout.paymentSummary!.subTotal,
          productTest.price * productTest.quantity);

      ///Verificar  costo de envio
      expect(catalogAndCheckout.paymentSummary!.shippingCost, shippingCost);

      ///Verificar  descuento de cupon
      expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 0);

      ///Verificar  total
      expect(catalogAndCheckout.paymentSummary!.getTotal(),
          productTest.price * productTest.quantity + shippingCost);
    });

    test('Con precio igual a la compra minima  de envio gratis', () {
      final productTest =
          Product(1, 1, "P1", "IM1", minimumFreeShipping, 1, false, []);

      catalogAndCheckout.products = [productTest];

      catalogAndCheckout.calculateTotal();

      ///Verificar subtotal
      expect(catalogAndCheckout.paymentSummary!.subTotal,
          productTest.price * productTest.quantity);

      ///Verificar  costo de envio
      expect(catalogAndCheckout.paymentSummary!.shippingCost, 0);

      ///Verificar  descuento de cupon
      expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 0);

      ///Verificar  total
      expect(catalogAndCheckout.paymentSummary!.getTotal(),
          productTest.price * productTest.quantity);
    });

    test('Precio mayor a la compra minima  de envio gratis', () {
      final productTest =
          Product(1, 1, "P1", "IM1", minimumFreeShipping + 1, 1, false, []);

      catalogAndCheckout.products = [productTest];

      catalogAndCheckout.calculateTotal();

      ///Verificar subtotal
      expect(catalogAndCheckout.paymentSummary!.subTotal,
          productTest.price * productTest.quantity);

      ///Verificar  costo de envio
      expect(catalogAndCheckout.paymentSummary!.shippingCost, 0);

      ///Verificar  descuento de cupon
      expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 0);

      ///Verificar  total
      expect(catalogAndCheckout.paymentSummary!.getTotal(),
          productTest.price * productTest.quantity);
    });
  });

  group(
      'Calculos de 1 solo producto con promocion pero solo con una sola unidad',
      () {
    test('Con precio menor a 500 ', () {
      final productTest =
          Product(1, 1, "P1", "IM1", minimumFreeShipping - 1, 1, true, []);
      catalogAndCheckout.products = [productTest];

      catalogAndCheckout.calculateTotal();

      ///Verificar subtotal
      expect(catalogAndCheckout.paymentSummary!.subTotal,
          productTest.price * productTest.quantity);

      ///Verificar  costo de envio
      expect(catalogAndCheckout.paymentSummary!.shippingCost, shippingCost);

      ///Verificar  descuento de cupon
      expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 0);

      ///Verificar  total
      expect(catalogAndCheckout.paymentSummary!.getTotal(),
          productTest.price * productTest.quantity + shippingCost);
    });

    test('Precio igual a la compra minima  de envio gratis', () {
      final productTest =
          Product(1, 1, "P1", "IM1", minimumFreeShipping, 1, true, []);

      catalogAndCheckout.products = [productTest];

      catalogAndCheckout.calculateTotal();

      ///Verificar subtotal
      expect(catalogAndCheckout.paymentSummary!.subTotal,
          productTest.price * productTest.quantity);

      ///Verificar  costo de envio
      expect(catalogAndCheckout.paymentSummary!.shippingCost, 0);

      ///Verificar  descuento de cupon
      expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 0);

      ///Verificar  total
      expect(catalogAndCheckout.paymentSummary!.getTotal(),
          productTest.price * productTest.quantity);
    });

    test('Con precio mayor a la compra minima  de envio gratis', () {
      final productTest =
          Product(1, 1, "P1", "IM1", minimumFreeShipping + 1, 1, true, []);

      catalogAndCheckout.products = [productTest];

      catalogAndCheckout.calculateTotal();

      ///Verificar subtotal
      expect(catalogAndCheckout.paymentSummary!.subTotal,
          productTest.price * productTest.quantity);

      ///Verificar  costo de envio
      expect(catalogAndCheckout.paymentSummary!.shippingCost, 0);

      ///Verificar  descuento de cupon
      expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 0);

      ///Verificar  total
      expect(catalogAndCheckout.paymentSummary!.getTotal(),
          productTest.price * productTest.quantity);
    });
  });

  test(
      'Calculos de 1 solo producto con cupon FIJO sin promocion Y CON VALOR '
      'POR DEBAJO DEL NECESARIO PARA APLICAR EL CUPON', () async {
    final productTest = Product(1, 1, "P1", "IM1", 999, 1, true, []);

    when(() => serviceI.getCoupon("FIJO")).thenReturn({"result": cuponFijo});

    catalogAndCheckout.products = [productTest];

    catalogAndCheckout.calculateTotal();
    await catalogAndCheckout.getCoupon("FIJO");

    ///Verficar la existencia del cupon
    expect(catalogAndCheckout.paymentSummary!.coupon!.id, 2);

    ///Verificar subtotal
    expect(catalogAndCheckout.paymentSummary!.subTotal,
        productTest.price * (productTest.quantity));

    ///Verificar  costo de envio
    expect(catalogAndCheckout.paymentSummary!.shippingCost, 0);

    ///Verificar  descuento de cupon
    expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 0);

    ///Verificar  total
    expect(catalogAndCheckout.paymentSummary!.getTotal(),
        productTest.price * (productTest.quantity));
  });

  test(
      'Calculos de 1 solo producto con cupon FIJO sin promocion Y CON VALOR '
      'IGUAL al NECESARIO PARA APLICAR EL CUPON', () async {
    final productTest = Product(1, 1, "P1", "IM1", 1000, 1, true, []);

    when(() => serviceI.getCoupon("FIJO")).thenReturn({"result": cuponFijo});

    catalogAndCheckout.products = [productTest];

    catalogAndCheckout.calculateTotal();
    await catalogAndCheckout.getCoupon("FIJO");

    ///Verficar la existencia del cupon
    expect(catalogAndCheckout.paymentSummary!.coupon!.id, 2);

    ///Verificar subtotal
    expect(catalogAndCheckout.paymentSummary!.subTotal,
        productTest.price * (productTest.quantity));

    ///Verificar  costo de envio
    expect(catalogAndCheckout.paymentSummary!.shippingCost, 0);

    ///Verificar  descuento de cupon
    expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 10);

    ///Verificar  total
    expect(catalogAndCheckout.paymentSummary!.getTotal(),
        (productTest.price * (productTest.quantity)) - 10);
  });

  test(
      'Calculos de 1 solo producto con cupon FIJO sin promocion Y CON VALOR '
      'MAYOR al NECESARIO PARA APLICAR EL CUPON', () async {
    final productTest = Product(1, 1, "P1", "IM1", 1001, 1, true, []);

    when(() => serviceI.getCoupon("FIJO")).thenReturn({"result": cuponFijo});

    catalogAndCheckout.products = [productTest];

    catalogAndCheckout.calculateTotal();
    await catalogAndCheckout.getCoupon("FIJO");

    ///Verficar la existencia del cupon
    expect(catalogAndCheckout.paymentSummary!.coupon!.id, 2);

    ///Verificar subtotal
    expect(catalogAndCheckout.paymentSummary!.subTotal,
        productTest.price * (productTest.quantity));

    ///Verificar  costo de envio
    expect(catalogAndCheckout.paymentSummary!.shippingCost, 0);

    ///Verificar  descuento de cupon
    expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 10);

    ///Verificar  total
    expect(catalogAndCheckout.paymentSummary!.getTotal(),
        (productTest.price * (productTest.quantity)) - 10);
  });

  test(
      'Calculos de 1 solo producto con cupon PORCENTAJE sin promocion Y CON VALOR '
      'POR DEBAJO del NECESARIO PARA APLICAR EL CUPON', () async {
    final productTest = Product(1, 1, "P1", "IM1", 699, 1, true, []);

    when(() => serviceI.getCoupon("PORCENTAJE"))
        .thenReturn({"result": cuponFijo});

    catalogAndCheckout.products = [productTest];

    catalogAndCheckout.calculateTotal();
    await catalogAndCheckout.getCoupon("PORCENTAJE");

    ///Verficar la existencia del cupon
    expect(catalogAndCheckout.paymentSummary!.coupon!.id, 2);

    ///Verificar subtotal
    expect(catalogAndCheckout.paymentSummary!.subTotal,
        productTest.price * (productTest.quantity));

    ///Verificar  costo de envio
    expect(catalogAndCheckout.paymentSummary!.shippingCost, 0);

    ///Verificar  descuento de cupon
    expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 0);

    ///Verificar  total
    expect(catalogAndCheckout.paymentSummary!.getTotal(),
        (productTest.price * (productTest.quantity)));
  });

  test(
      'Calculos de 1 solo producto con cupon PORCENTAJE sin promocion Y CON VALOR '
      'IGUAL al NECESARIO PARA APLICAR EL CUPON', () async {
    final productTest = Product(1, 1, "P1", "IM1", 700, 1, true, []);

    when(() => serviceI.getCoupon("PORCENTAJE"))
        .thenReturn({"result": cuponPorcentaje});

    catalogAndCheckout.products = [productTest];

    catalogAndCheckout.calculateTotal();
    await catalogAndCheckout.getCoupon("PORCENTAJE");

    ///Verficar la existencia del cupon
    expect(
        catalogAndCheckout.paymentSummary!.coupon!.id, cuponPorcentaje["id"]);

    ///Verificar subtotal
    expect(catalogAndCheckout.paymentSummary!.subTotal,
        productTest.price * (productTest.quantity));

    ///Verificar  costo de envio
    expect(catalogAndCheckout.paymentSummary!.shippingCost, 0);

    ///Verificar  descuento de cupon
    expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(),
        (productTest.price * 10) / 100);

    ///Verificar  total
    expect(
        catalogAndCheckout.paymentSummary!.getTotal(),
        (productTest.price * (productTest.quantity)) -
            catalogAndCheckout.paymentSummary!.getDiscountCoupon());
  });

  test(
      'Calculos de 1 solo producto con cupon PORCENTAJE sin promocion Y CON VALOR '
      'MAYOR al NECESARIO PARA APLICAR EL CUPON', () async {
    final productTest = Product(1, 1, "P1", "IM1", 800, 1, true, []);

    when(() => serviceI.getCoupon("PORCENTAJE"))
        .thenReturn({"result": cuponPorcentaje});

    catalogAndCheckout.products = [productTest];

    catalogAndCheckout.calculateTotal();
    await catalogAndCheckout.getCoupon("PORCENTAJE");

    ///Verficar la existencia del cupon
    expect(
        catalogAndCheckout.paymentSummary!.coupon!.id, cuponPorcentaje["id"]);

    ///Verificar subtotal
    expect(catalogAndCheckout.paymentSummary!.subTotal,
        productTest.price * (productTest.quantity));

    ///Verificar  costo de envio
    expect(catalogAndCheckout.paymentSummary!.shippingCost, 0);

    ///Verificar  descuento de cupon
    expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(),
        (productTest.price * 10) / 100);

    ///Verificar  total
    expect(
        catalogAndCheckout.paymentSummary!.getTotal(),
        (productTest.price * (productTest.quantity)) -
            catalogAndCheckout.paymentSummary!.getDiscountCoupon());
  });

  test(
      'Calculos de 1 solo producto con promocion con '
      '6 unidades se deben de cobrar 5 unidades', () {
    final productTest = Product(1, 1, "P1", "IM1", 200, 6, true, []);

    catalogAndCheckout.products = [productTest];

    catalogAndCheckout.calculateTotal();

    ///Verificar subtotal
    expect(catalogAndCheckout.paymentSummary!.subTotal,
        productTest.price * (productTest.quantity - 1));

    ///Verificar  costo de envio
    expect(catalogAndCheckout.paymentSummary!.shippingCost, 0);

    ///Verificar  descuento de cupon
    expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 0);

    ///Verificar  total
    expect(catalogAndCheckout.paymentSummary!.getTotal(),
        productTest.price * (productTest.quantity - 1));
  });
}
