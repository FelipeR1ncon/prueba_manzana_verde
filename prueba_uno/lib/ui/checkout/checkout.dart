import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:separate_api/app_controller.dart';
import 'package:separate_api/model/payment_summary.dart';

import 'checkout_product_line.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final ScrollController _sc = ScrollController();
  final TextEditingController _tc = TextEditingController();

  var loadInitialData = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 200));
      _sc.animateTo(_sc.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (loadInitialData) {
      Provider.of<CatalogCartAndCheckout>(context).calculateTotal();
      loadInitialData = false;
    }
  }

  @override
  void dispose() {
    _tc.dispose();
    super.dispose();
  }

  final inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.grey.shade400,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final PaymentSummary summary =
        Provider.of<CatalogCartAndCheckout>(context).paymentSummary!;
    return Scaffold(
      appBar: AppBar(title: const Text("Pago")),
      body: Consumer<CatalogCartAndCheckout>(
        builder: (context, cart, child) {
          return SingleChildScrollView(
            controller: _sc,
            dragStartBehavior: DragStartBehavior.down,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Wrap(
                  runSpacing: 20,
                  children: cart.products
                      .where((element) => element.selected == 1)
                      .map((e) {
                    return CheckoutProductLine(product: e);
                  }).toList(),
                ),
                const Divider(height: 50),
                if (cart.paymentSummary!.coupon == null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: TextField(
                                controller: _tc,
                                decoration: InputDecoration(
                                  hintText: "Cupón",
                                  isDense: true,
                                  enabledBorder: inputBorder,
                                  border: inputBorder,
                                  errorBorder: inputBorder,
                                  focusedBorder: inputBorder,
                                  disabledBorder: inputBorder,
                                  focusedErrorBorder: inputBorder,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                cart.getCoupon(_tc.text);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: const Text("Aplicar"),
                            ),
                          ),
                        ],
                      ),
                      if (cart.error != null)
                        Text(
                          cart.error!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        )
                    ],
                  ),
                if (cart.paymentSummary!.coupon != null)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Cupón ${cart.paymentSummary!.coupon!.code} aplicado",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          cart.removeCoupon();
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.grey,
                      )
                    ],
                  ),
                const Divider(height: 50),
                Wrap(
                  runSpacing: 15,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                            child: Text(
                          "Subtotal",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                        Text(
                          summary.subTotal.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                            child: Text(
                          "Descuento por cupón",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                        Text(
                          cart.paymentSummary!.getDiscountCoupon().toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                            child: Text(
                          "Costo de envío",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                        Text(
                          summary.shippingCost.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(height: 50),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      cart.paymentSummary!.getTotal().toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 50),
                SizedBox(
                  height: 50,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      cart.pay(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      "Pagar",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
