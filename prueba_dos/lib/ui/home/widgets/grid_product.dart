import 'package:flutter/material.dart';
import 'package:prueba_dos/ui/components/card/product/product_card.dart';
import 'package:prueba_dos/ui/components/card/product/product_model.dart';

class GridProduct extends StatelessWidget {
  const GridProduct({
    Key? key,
    required this.products,
    this.plusBtnOnPressed,
    this.minusBtnOnPressed,
  }) : super(key: key);

  final List<ProductUIModel> products;
  final void Function()? plusBtnOnPressed;
  final void Function()? minusBtnOnPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
              child: Wrap(
            direction: Axis.horizontal,
            spacing: 8,
            runSpacing: 9,
            children: [
              for (var item in products)
                SizedBox(
                  width: MediaQuery.of(context).size.width >= 200
                      ? MediaQuery.of(context).size.width * 0.45
                      : MediaQuery.of(context).size.width * 0.70,
                  child: ProductCard(
                    minusBtnOnPressed: minusBtnOnPressed,
                    plusBtnOnPressed: plusBtnOnPressed,
                    product: item,
                  ),
                )
            ],
          ))),
    );
  }
}
