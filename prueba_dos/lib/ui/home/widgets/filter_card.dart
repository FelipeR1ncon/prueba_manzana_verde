import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prueba_dos/ui/components/card/filter_card.dart';
import 'package:prueba_dos/ui/resources/icon/path_icon.dart';
import 'package:prueba_dos/ui/resources/style/text_style.dart';

class CardFilter extends StatelessWidget {
  CardFilter({
    Key? key,
  }) : super(key: key);

  final List<String> options = [
    "Más relevante",
    "Menor precio",
    "Mayor precio",
    "Ofertas (Mayor a menor descuento)"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  enableDrag: true,
                  barrierColor: const Color(0x80000000),
                  builder: (context) {
                    return Wrap(
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
                                  child:
                                      SvgPicture.asset(LocalIcon.xCircle.path))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
                          child: Wrap(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 36),
                                child: Text("Ordenar por",
                                    style: LocalTextStyle.titleText),
                              ),
                              Wrap(children: [
                                for (var option in options)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            option,
                                            style: LocalTextStyle.bodyRegular,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ])
                            ],
                          ),
                        )
                      ],
                    );
                  });
            },
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: FilterCard(
                    pathIcon: LocalIcon.arrowSwap.path, text: "Ordenar")),
          ),
          const Flexible(
            fit: FlexFit.tight,
            child: SizedBox(),
          ),
          GestureDetector(
            onTap: () {},
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: FilterCard(
                  pathIcon: LocalIcon.chevronLeft.path,
                  text: "Marcas",
                  showNotificationPoint: true,
                )),
          ),
        ],
      ),
    );
  }
}
