// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:separate_api/app_controller.dart';

import 'package:separate_api/main.dart';
import 'package:separate_api/model/producto.dart';
import 'package:separate_api/service/service_interface.dart';
import 'package:separate_api/ui/checkout/checkout.dart';

class MockService extends Mock implements ServiceI {}

void main() {
  late ServiceI serviceI;
  late CatalogCartAndCheckout catalogAndCheckout;
  final cuponFijo = {
    "id": 2,
    "code": "FIJO",
    "description": "100 de descuento en el total de tu compra",
    "type": "DISCOUNT_FIXED",
    "payload": {
      "value": 10,
      "minimum": 400,
    },
  };

  Widget testWidget = const MediaQuery(
      data: MediaQueryData(), child: MaterialApp(home: CheckoutPage()));

  setUp(() {
    serviceI = MockService();
    catalogAndCheckout = CatalogCartAndCheckout(serviceI);
    final productTest = Product(1, 1, "Bolsa", "bolsa", 450, 1, false, []);

    catalogAndCheckout.products = [productTest];
  });

  testWidgets(
      'Verificar datos en la pantalla de pago antes y despues de aplicar un cupon',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => catalogAndCheckout,
          ),
        ],
        child: Builder(
          builder: (_) => testWidget,
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 250));

    ///Verfificamos que el cupon este en 0
    expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 0);

    ///Verfificamos que el sub total corresponda
    expect(catalogAndCheckout.paymentSummary!.subTotal, 450.0);

    ///Verfificamos que el costo de envio corresponda
    expect(catalogAndCheckout.paymentSummary!.shippingCost, 30.0);

    ///Verfificamos que el total corresponda
    expect(catalogAndCheckout.paymentSummary!.getTotal(), 480.0);

    ///////////////VERIFACION DE UI SIN CUPON ///////////////////
    ///Sub total
    expect(find.text(catalogAndCheckout.paymentSummary!.subTotal.toString()),
        findsOneWidget);

    ///Costo de envio
    expect(
        find.text(catalogAndCheckout.paymentSummary!.shippingCost.toString()),
        findsOneWidget);

    ///Descuento por cupon
    expect(
        find.text(
            catalogAndCheckout.paymentSummary!.getDiscountCoupon().toString()),
        findsOneWidget);

    ///TOTAL
    expect(find.text(catalogAndCheckout.paymentSummary!.getTotal().toString()),
        findsOneWidget);

    ///APLICAMOS UN CUPOM
    when(() => serviceI.getCoupon("FIJO")).thenReturn({"result": cuponFijo});
    await tester.enterText(find.byType(TextField), "FIJO");
    await tester.pump();
    await tester.tap(find.text("Aplicar"));
    await tester.pump();

    ///////////////VERIFACION DE UI CON CUPON  FIJO de 10///////////////////

    ///Verfificamos que ahora el cupon no este en 0
    expect(catalogAndCheckout.paymentSummary!.getDiscountCoupon(), 10);

    ///Verfificamos que este el nuevo descuento por cupon
    expect(
        find.text(
            catalogAndCheckout.paymentSummary!.getDiscountCoupon().toString()),
        findsOneWidget);

    ///Sub total
    expect(find.text(catalogAndCheckout.paymentSummary!.subTotal.toString()),
        findsOneWidget);

    ///Costo de envio
    expect(
        find.text(catalogAndCheckout.paymentSummary!.shippingCost.toString()),
        findsOneWidget);

    ///TOTAL
    expect(find.text(catalogAndCheckout.paymentSummary!.getTotal().toString()),
        findsOneWidget);
  });
}
