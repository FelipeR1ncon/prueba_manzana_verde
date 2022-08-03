import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:prueba_dos/ui/resources/color/color.dart';
import 'package:prueba_dos/ui/resources/style/text_style.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {Key? key,
      required this.productImagePath,
      required this.productName,
      required this.productMeasurement,
      required this.productBrand,
      required this.normalPrice,
      required this.offerPrice,
      this.unitsAvailable})
      : super(key: key);

  final String productImagePath;
  final String productName;
  final String productMeasurement;
  final String productBrand;
  final String normalPrice;
  final String offerPrice;
  final double? unitsAvailable;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 86,
          width: 164,
          child: Stack(
            children: [
              Image.asset(widget.productImagePath),
              Positioned(
                  top: 2,
                  left: 8,
                  child: Container(
                      decoration: BoxDecoration(
                        color: LocalColors.verdeV200,
                        borderRadius: BorderRadius.circular(48),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        child: Text("En oferta",
                            style: LocalTextStyle.bodyRegular.copyWith(
                                color: LocalColors.blanco, fontSize: 12),
                            textAlign: TextAlign.center),
                      )))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
          child: Wrap(
            children: [
              Expanded(
                  child: Text(
                widget.productName,
                style: LocalTextStyle.bodyRegular,
              )),
              Expanded(
                  child: Text(widget.productMeasurement,
                      style: LocalTextStyle.bodyRegular
                          .copyWith(color: LocalColors.grisN70, fontSize: 12))),
              Expanded(
                  child: Text(
                widget.productBrand,
                style: LocalTextStyle.bodyRegular
                    .copyWith(color: LocalColors.verdeV200, fontSize: 12),
              )),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  AutoSizeText(
                    widget.normalPrice,
                    style: LocalTextStyle.emphasisText,
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(12, 4, 4, 12),
                      child: AutoSizeText(widget.offerPrice,
                          style: LocalTextStyle.bodyRegular.copyWith(
                            decoration: TextDecoration.lineThrough,
                          ))),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
