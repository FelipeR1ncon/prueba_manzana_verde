import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:separate_api/app_controller.dart';
import 'package:separate_api/model/producto.dart';
import 'package:separate_api/service/service_interface.dart';

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
    final productTest =
        Product(0, 1, "P1", "IM1", minimumFreeShipping - 1, 0, false, []);
    catalogAndCheckout.products = [productTest];

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

  group('Calculos de 1 solo producto con promocion y distintos casos de precio',
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

  group('Casos de  aplicacion de cupones', () {
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
  });

  group('Casos de aplicaciones de promociones', () {
    test(
        'Calculos de 1 solo producto con promocion con '
        '2 unidades se deben de cobrar 2 unidades', () {
      final productTest = Product(1, 1, "P1", "IM1", 200, 2, true, []);

      catalogAndCheckout.products = [productTest];

      catalogAndCheckout.calculateTotal();

      ///Verificar subtotal
      expect(catalogAndCheckout.paymentSummary!.subTotal,
          productTest.price * (productTest.quantity));

      ///Verificar  costo de envio
      expect(catalogAndCheckout.paymentSummary!.shippingCost, shippingCost);

      ///Verificar  descuento de cupon
      expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 0);

      ///Verificar  total
      expect(catalogAndCheckout.paymentSummary!.getTotal(),
          productTest.price * (productTest.quantity) + shippingCost);
    });

    test(
        'Calculos de 1 solo producto con promocion con '
        '3 unidades se deben de cobrar 2 unidades', () {
      final productTest = Product(1, 1, "P1", "IM1", 100, 3, true, []);

      catalogAndCheckout.products = [productTest];

      catalogAndCheckout.calculateTotal();

      ///Verificar subtotal
      expect(catalogAndCheckout.paymentSummary!.subTotal,
          productTest.price * (productTest.quantity - 1));

      ///Verificar  costo de envio
      expect(catalogAndCheckout.paymentSummary!.shippingCost, shippingCost);

      ///Verificar  descuento de cupon
      expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 0);

      ///Verificar  total
      expect(catalogAndCheckout.paymentSummary!.getTotal(),
          productTest.price * (productTest.quantity - 1) + shippingCost);
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
  });

  group('Casos de aplicaciones de paquetes', () {
    test(
        'Caso de 2 productos de los cuales uno tiene al otro dentro de sus match',
        () {
      final productTest1 = Product(1, 1, "P1", "IM1", 200, 2, false, []);
      final productTest2 = Product(1, 2, "P2", "IM2", 300, 2, false, [1]);
      double subTotalExpected = (productTest1.quantity *
              (productTest1.price - (productTest1.price * 0.10))) +
          (productTest2.quantity *
              ((productTest2.price - (productTest2.price * 0.10))));

      catalogAndCheckout.products = [productTest1, productTest2];

      catalogAndCheckout.calculateTotal();

      ///Verificar subtotal
      expect(catalogAndCheckout.paymentSummary!.subTotal, subTotalExpected);

      ///Verificar  costo de envio
      expect(catalogAndCheckout.paymentSummary!.shippingCost, 0);

      ///Verificar  descuento de cupon
      expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 0);

      ///Verificar  total
      expect(catalogAndCheckout.paymentSummary!.getTotal(), subTotalExpected);
    });

    test(
        'Caso de 2 productos de los cuales uno tiene al otro dentro de sus match'
        'pero este otro esta en promocion pero solo con 1 unidad, por lo tanto la '
        'promocion no aplica', () {
      final productTest1 = Product(1, 1, "P1", "IM1", 200, 1, true, []);
      final productTest2 = Product(1, 2, "P2", "IM2", 300, 2, false, [1]);

      double subTotalExpected = productTest1.price * productTest1.quantity +
          productTest2.price * productTest2.quantity * 1.0;

      catalogAndCheckout.products = [productTest1, productTest2];

      catalogAndCheckout.calculateTotal();

      ///Verificar subtotal
      expect(catalogAndCheckout.paymentSummary!.subTotal, subTotalExpected);

      ///Verificar  costo de envio
      expect(catalogAndCheckout.paymentSummary!.shippingCost, 0);

      ///Verificar  descuento de cupon
      expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 0);

      ///Verificar  total
      expect(catalogAndCheckout.paymentSummary!.getTotal(), subTotalExpected);
    });

    test(
        'Caso de 2 productos de los cuales uno tiene al otro dentro de sus match'
        'pero este otro esta en promocion  con 3 unidades, por lo tanto la '
        'promocion aplica', () {
      final productTest1 = Product(1, 1, "P1", "IM1", 200, 3, true, []);
      final productTest2 = Product(1, 2, "P2", "IM2", 300, 2, false, [1]);

      double subTotalExpected =
          productTest1.price * (productTest1.quantity - 1) +
              productTest2.price * productTest2.quantity * 1.0;

      catalogAndCheckout.products = [productTest1, productTest2];

      catalogAndCheckout.calculateTotal();

      ///Verificar subtotal
      expect(catalogAndCheckout.paymentSummary!.subTotal, subTotalExpected);

      ///Verificar  costo de envio
      expect(catalogAndCheckout.paymentSummary!.shippingCost, 0);

      ///Verificar  descuento de cupon
      expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 0);

      ///Verificar  total
      expect(catalogAndCheckout.paymentSummary!.getTotal(), subTotalExpected);
    });
  });

  group('Combinaciones de paquetes con promeciones y cupones', () {
    test(
        'Caso de 3 productos donde dos de estos hacen match y al ultimo se le aplica una promocion',
        () {
      final productTest1 = Product(1, 1, "P1", "IM1", 200, 3, false, []);
      final productTest2 = Product(1, 2, "P2", "IM2", 300, 2, false, [1]);
      final productTest3 = Product(1, 3, "P3", "IM3", 100, 3, true, []);

      double subTotalExpected =
          (productTest1.price * 0.90) * productTest1.quantity +
              (productTest2.price * 0.90) * productTest2.quantity +
              productTest3.price * (productTest3.quantity - 1) * 1.0;

      catalogAndCheckout.products = [productTest1, productTest2, productTest3];

      catalogAndCheckout.calculateTotal();

      ///Verificar subtotal
      expect(catalogAndCheckout.paymentSummary!.subTotal, subTotalExpected);

      ///Verificar  costo de envio
      expect(catalogAndCheckout.paymentSummary!.shippingCost, 0);

      ///Verificar  descuento de cupon
      expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 0);

      ///Verificar  total
      expect(catalogAndCheckout.paymentSummary!.getTotal(), subTotalExpected);
    });

    test(
        'Caso de 3 productos donde dos de estos hacen match y al ultimo'
        'tiene en sus match a un producto que ya hizo match', () {
      final productTest1 = Product(1, 1, "P1", "IM1", 200, 3, false, []);
      final productTest2 = Product(1, 2, "P2", "IM2", 300, 2, false, [1]);
      final productTest3 = Product(1, 3, "P3", "IM3", 100, 3, false, [1]);

      double subTotalExpected =
          (productTest1.price * 0.90) * productTest1.quantity +
              (productTest2.price * 0.90) * productTest2.quantity +
              productTest3.price * (productTest3.quantity) * 1.0;

      catalogAndCheckout.products = [productTest1, productTest2, productTest3];

      catalogAndCheckout.calculateTotal();

      ///Verificar subtotal
      expect(catalogAndCheckout.paymentSummary!.subTotal, subTotalExpected);

      ///Verificar  costo de envio
      expect(catalogAndCheckout.paymentSummary!.shippingCost, 0);

      ///Verificar  descuento de cupon
      expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 0);

      ///Verificar  total
      expect(catalogAndCheckout.paymentSummary!.getTotal(), subTotalExpected);
    });

    test(
        'Caso de 2 productos donde dos de estos hacen match y se le aplica'
        'un cupon de tipo FIJO', () async {
      final productTest1 = Product(1, 1, "P1", "IM1", 200, 3, false, []);
      final productTest2 = Product(1, 2, "P2", "IM2", 300, 2, false, [1]);

      double subTotalExpected =
          (productTest1.price * 0.90) * productTest1.quantity +
              (productTest2.price * 0.90) * productTest2.quantity;

      catalogAndCheckout.products = [productTest1, productTest2];
      when(() => serviceI.getCoupon("FIJO")).thenReturn({"result": cuponFijo});

      catalogAndCheckout.calculateTotal();
      await catalogAndCheckout.getCoupon("FIJO");

      ///Verificar subtotal
      expect(catalogAndCheckout.paymentSummary!.subTotal, subTotalExpected);

      ///Verificar  costo de envio
      expect(catalogAndCheckout.paymentSummary!.shippingCost, 0);

      ///Verificar  descuento de cupon
      expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 10);

      ///Verificar  total
      expect(
          catalogAndCheckout.paymentSummary!.getTotal(), subTotalExpected - 10);
    });

    test(
        'Caso de 2 productos donde dos de estos hacen match y se le aplica'
        'un cupon de tipo PORCENTAJE', () async {
      final productTest1 = Product(1, 1, "P1", "IM1", 200, 3, false, []);
      final productTest2 = Product(1, 2, "P2", "IM2", 300, 2, false, [1]);

      double subTotalExpected =
          (productTest1.price * 0.90) * productTest1.quantity +
              (productTest2.price * 0.90) * productTest2.quantity;

      catalogAndCheckout.products = [productTest1, productTest2];
      when(() => serviceI.getCoupon("PORCENTAJE"))
          .thenReturn({"result": cuponPorcentaje});

      catalogAndCheckout.calculateTotal();
      await catalogAndCheckout.getCoupon("PORCENTAJE");

      ///Verificar subtotal
      expect(catalogAndCheckout.paymentSummary!.subTotal, subTotalExpected);

      ///Verificar  costo de envio
      expect(catalogAndCheckout.paymentSummary!.shippingCost, 0);

      ///Verificar  descuento de cupon
      expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(),
          subTotalExpected * 0.10);

      ///Verificar  total
      expect(catalogAndCheckout.paymentSummary!.getTotal(),
          subTotalExpected - subTotalExpected * 0.10);
    });

    test(
        'Caso de 6 productos donde 2 de estos hacen match, el 3 de estos tiene una promocion , 4 de '
        'estos tiene en sus match al que tiene promocion '
        'y el 5 tiene en sus match al anterior producto, el 6 es un producto '
        'sin promocion ni match y ademas se le aplica un cupo de tipo FIJO',
        () async {
      final productTest1 = Product(1, 1, "P1", "IM1", 100, 1, false, []);
      final productTest2 = Product(1, 2, "P2", "IM2", 100, 1, false, [1]);
      final productTest3 = Product(1, 3, "P3", "IM3", 100, 4, true, []);
      final productTest4 = Product(1, 4, "P4", "IM4", 100, 1, false, [3]);
      final productTest5 = Product(1, 5, "P5", "IM5", 100, 1, false, [4]);
      final productTest6 = Product(1, 6, "P6", "IM6", 100, 10, false, []);

      double subTotalExpected =
          ((productTest1.price * 0.90) * productTest1.quantity) +
              ((productTest2.price * 0.90) * productTest2.quantity) +
              (productTest3.price * (productTest3.quantity - 1)) +
              ((productTest4.price * 0.90) * productTest4.quantity) +
              ((productTest5.price * 0.90) * productTest5.quantity) +
              productTest6.price * productTest6.quantity;

      catalogAndCheckout.products = [
        productTest1,
        productTest2,
        productTest3,
        productTest4,
        productTest5,
        productTest6
      ];

      when(() => serviceI.getCoupon("FIJO")).thenReturn({"result": cuponFijo});

      catalogAndCheckout.calculateTotal();
      await catalogAndCheckout.getCoupon("FIJO");

      ///Verificar subtotal
      expect(catalogAndCheckout.paymentSummary!.subTotal, subTotalExpected);

      ///Verificar  costo de envio
      expect(catalogAndCheckout.paymentSummary!.shippingCost, 0);

      ///Verificar  descuento de cupon
      expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 10);

      ///Verificar  total
      expect(
          catalogAndCheckout.paymentSummary!.getTotal(), subTotalExpected - 10);
    });

    test(
        'Caso de 6 productos donde 2 de estos hacen match, el 3 de estos tiene una promocion , 4 de '
        'estos tiene en sus match al que tiene promocion '
        'y el 5 tiene en sus match al anterior producto, el 6 es un producto '
        'sin promocion ni match y ademas se le aplica un cupo de tipo PORCENTAJE',
        () async {
      final productTest1 = Product(1, 1, "P1", "IM1", 100, 1, false, []);
      final productTest2 = Product(1, 2, "P2", "IM2", 100, 1, false, [1]);
      final productTest3 = Product(1, 3, "P3", "IM3", 100, 4, true, []);
      final productTest4 = Product(1, 4, "P4", "IM4", 100, 1, false, [3]);
      final productTest5 = Product(1, 5, "P5", "IM5", 100, 1, false, [4]);
      final productTest6 = Product(1, 6, "P6", "IM6", 100, 10, false, []);

      double subTotalExpected =
          ((productTest1.price * 0.90) * productTest1.quantity) +
              ((productTest2.price * 0.90) * productTest2.quantity) +
              (productTest3.price * (productTest3.quantity - 1)) +
              ((productTest4.price * 0.90) * productTest4.quantity) +
              ((productTest5.price * 0.90) * productTest5.quantity) +
              productTest6.price * productTest6.quantity;

      catalogAndCheckout.products = [
        productTest1,
        productTest2,
        productTest3,
        productTest4,
        productTest5,
        productTest6
      ];

      when(() => serviceI.getCoupon("PORCENTAJE"))
          .thenReturn({"result": cuponPorcentaje});

      catalogAndCheckout.calculateTotal();
      await catalogAndCheckout.getCoupon("PORCENTAJE");

      ///Verificar subtotal
      expect(catalogAndCheckout.paymentSummary!.subTotal, subTotalExpected);

      ///Verificar  costo de envio
      expect(catalogAndCheckout.paymentSummary!.shippingCost, 0);

      ///Verificar  descuento de cupon
      expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(),
          subTotalExpected * 0.10);

      ///Verificar  total
      expect(catalogAndCheckout.paymentSummary!.getTotal(),
          subTotalExpected - subTotalExpected * 0.10);
    });
  });
}
