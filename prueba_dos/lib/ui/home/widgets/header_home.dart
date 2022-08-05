import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prueba_dos/ui/components/input/location_input.dart';
import 'package:prueba_dos/ui/resources/icon/path_icon.dart';
import 'package:prueba_dos/ui/resources/images/path_images.dart';
import 'package:prueba_dos/ui/resources/style/text_style.dart';

import '../../components/input/search_input.dart';
import '../../resources/color/color.dart';
import 'export.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({
    Key? key,
    required this.quatityProducts,
  }) : super(key: key);

  final int quatityProducts;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: true,
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.95),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            context: context,
            enableDrag: true,
            barrierColor: const Color(0x80000000),
            backgroundColor: LocalColors.white,
            builder: (context) {
              return SingleChildScrollView(
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 13, 13, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(LocalIcon.xCircle.path))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: Expanded(
                          child: AutoSizeText(
                        "Consultar cobertura",
                        maxLines: 2,
                        style: LocalTextStyle.titleText.copyWith(
                            fontSize: 24, color: LocalColors.grisN100),
                      )),
                    ),
                    const Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 13),
                        child: Expanded(
                          child: AutoSizeText(
                            "¿A donde te llevamos tus pedidos?",
                            maxLines: 2,
                            style: LocalTextStyle.bodyRegular,
                          ),
                        )),
                    SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        LocalImage.map.path,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: const Padding(
                          padding: EdgeInsets.all(20),
                          child: LocationInput(hintText: "Dirección")),
                    ),
                    const Divider(
                      height: 0.4,
                      color: LocalColors.grisN30,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: 42,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: FilledButton(
                                text: "Continuar",
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ]),
                    )
                  ],
                ),
              );
            });
      },
      child: Container(
        color: LocalColors.grisN20,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(LocalIcon.home.path),
                        const SizedBox(
                          width: 9.8,
                        ),
                        const Text(
                          "Inicio",
                          style: LocalTextStyle.bodyBold,
                        )
                      ],
                    )),
                    Flexible(
                        child: Container(
                      width: 58,
                      height: 32,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: LocalColors.verdeV200, width: 2),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(LocalIcon.shoppingCart.path),
                          const SizedBox(
                            width: 6,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(quatityProducts.toString(),
                                style: LocalTextStyle.bodyBold.copyWith(
                                  color: LocalColors.verdeV200,
                                  fontSize: 16,
                                )),
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const SearchInput(
                placeHolder: "Buscar en market",
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      LocalIcon.locationIndicator.path,
                      color: LocalColors.grisN70,
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Expanded(
                        child: Text(
                      "Consultar cobertura",
                      style: LocalTextStyle.bodyRegular
                          .copyWith(color: LocalColors.grisN70),
                    )),
                    SvgPicture.asset(
                      LocalIcon.chevronLeft.path,
                      color: LocalColors.grisN70,
                      height: 8,
                      width: 12,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
