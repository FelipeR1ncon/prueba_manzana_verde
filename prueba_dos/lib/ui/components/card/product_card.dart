import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:prueba_dos/ui/components/button/text_button.dart';
import 'package:prueba_dos/ui/resources/color/color.dart';
import 'package:prueba_dos/ui/resources/style/text_style.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.productImagePath,
    required this.productName,
    required this.productMeasurement,
    required this.productBrand,
    required this.normalPrice,
    required this.offerPrice,
  }) : super(key: key);

  final String productImagePath;
  final String productName;
  final String productMeasurement;
  final String productBrand;
  final String normalPrice;
  final String offerPrice;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0x0AA6A4A4),
            blurRadius: 0.32,
            offset: Offset(0, 0.09),
          ),
          BoxShadow(
            color: Color(0x0DA6A4A4),
            blurRadius: 0.75,
            offset: Offset(0, 0.22),
          ),
        ],
        color: LocalColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 86,
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Image.asset(widget.productImagePath,
                        fit: BoxFit.contain)),
                Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                        decoration: BoxDecoration(
                          color: LocalColors.verdeV200,
                          borderRadius: BorderRadius.circular(48),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 10),
                          child: Text("En oferta",
                              style: LocalTextStyle.bodyRegular.copyWith(
                                  color: LocalColors.white, fontSize: 12),
                              textAlign: TextAlign.start),
                        )))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(children: [
                  Expanded(
                    child: Text(
                      widget.productName,
                      style: LocalTextStyle.bodyRegular,
                    ),
                  )
                ]),
                Row(children: [
                  Text(widget.productMeasurement,
                      textAlign: TextAlign.start,
                      style: LocalTextStyle.bodyRegular
                          .copyWith(color: LocalColors.grisN70, fontSize: 12)),
                ]),
                Row(children: [
                  Text(
                    widget.productBrand,
                    style: LocalTextStyle.bodyRegular
                        .copyWith(color: LocalColors.verdeV200, fontSize: 12),
                  ),
                ]),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      widget.normalPrice,
                      textAlign: TextAlign.start,
                      style: LocalTextStyle.emphasisText,
                    ),
                    Expanded(
                      child: AutoSizeText(widget.offerPrice,
                          textAlign: TextAlign.center,
                          style: LocalTextStyle.bodyRegular.copyWith(
                            decoration: TextDecoration.lineThrough,
                          )),
                    ),
                  ],
                ),
                FilledButton(
                  onPressed: () {},
                  text: "Agregar",
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
