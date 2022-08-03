import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prueba_dos/ui/resources/color/color.dart';
import 'package:prueba_dos/ui/resources/icon/path_icon.dart';
import 'package:prueba_dos/ui/resources/style/text_style.dart';

import '../components/input/search_input.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const HeaderHome(),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 24, 12, 12),
            child: Text(
              "Snack",
              style: LocalTextStyle.titleText.copyWith(fontSize: 32),
            ),
          ),
          Container(
            height: 41,
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 12),
            decoration: const BoxDecoration(
                color: LocalColors.grisN20,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Ordenar",
                  style: LocalTextStyle.bodyRegular,
                ),
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(LocalIcon.arrowSwap.path)
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class HeaderHome extends StatelessWidget {
  const HeaderHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LocalColors.grisN20,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
                        border:
                            Border.all(color: LocalColors.verdeV200, width: 2),
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
                          child: Text("0",
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
    );
  }
}
