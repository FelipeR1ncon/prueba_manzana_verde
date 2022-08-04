import 'package:flutter/material.dart';
import 'package:prueba_dos/ui/components/card/product/product_card.dart';
import 'package:prueba_dos/ui/components/card/product/product_model.dart';

class GridProduct extends StatelessWidget {
  const GridProduct({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<ProductUIModel> products;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    MediaQuery.of(context).size.height > 300 ? 2 : 1,
                mainAxisExtent: 280,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12),
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductCard(
                product: products[index],
              );
            }),
      ),
    );
  }
}