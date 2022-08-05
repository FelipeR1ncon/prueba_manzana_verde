import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:prueba_dos/ui/components/card/filter_card.dart';
import 'package:prueba_dos/ui/resources/color/color.dart';
import 'package:prueba_dos/ui/resources/icon/path_icon.dart';
import 'package:prueba_dos/ui/resources/style/text_style.dart';

import 'export.dart';

class CardFilter extends StatefulWidget {
  const CardFilter({
    Key? key,
  }) : super(key: key);

  @override
  State<CardFilter> createState() => _CardFilterState();
}

class _CardFilterState extends State<CardFilter> {
  final numsRadioOptionsOrder = 0;

  ///Opciones para mostrar en el bottomSheet de oder
  final Map<String, bool> optionsOrder = {
    "Más relevante": true,
    "Menor precio": false,
    "Mayor precio": false,
    "Ofertas (Mayor a menor descuento)": false
  };

  ///Opciones para mostrar en el bottomSheet los filtros de marcas
  final Map<String, bool> optionsBrand = {
    "Lakanto": true,
    "Nutrishake": false,
    "Marca comercial": false,
    "Snacksanto": true,
    "Lakantoo": false,
    "Nutrishakee": true
  };

  ///Index del radio button seleccionado en los posibles ordenes
  int _indexSeletedInOrder = 0;

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
                  isScrollControlled: true,
                  isDismissible: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  context: context,
                  enableDrag: true,
                  barrierColor: const Color(0x80000000),
                  builder: (context) {
                    return StatefulBuilder(builder:
                        (BuildContext context, StateSetter setModalState) {
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
                                    child: SvgPicture.asset(
                                        LocalIcon.xCircle.path))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
                            child: Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 36),
                                  child: AutoSizeText("Ordenar por",
                                      style: LocalTextStyle.emphasisText
                                          .copyWith(fontSize: 18)),
                                ),
                                Wrap(children: [
                                  for (int i = 0;
                                      i < optionsOrder.entries.toList().length;
                                      i++)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: AutoSizeText(
                                            optionsOrder.entries
                                                .toList()[i]
                                                .key,
                                            maxLines: 3,
                                            style: LocalTextStyle.bodyRegular
                                                .copyWith(
                                                    color:
                                                        LocalColors.grisN100),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: Radio(
                                              value: i,
                                              groupValue: _indexSeletedInOrder,
                                              activeColor:
                                                  LocalColors.verdeV200,
                                              onChanged: (newIndex) {
                                                setState(() {
                                                  _indexSeletedInOrder =
                                                      newIndex as int;
                                                });
                                                setModalState(() {});
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                ])
                              ],
                            ),
                          )
                        ],
                      );
                    });
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
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  isDismissible: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  context: context,
                  enableDrag: true,
                  barrierColor: const Color(0x80000000),
                  builder: (context) {
                    return StatefulBuilder(builder:
                        (BuildContext context, StateSetter setModalState) {
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
                                    child: SvgPicture.asset(
                                        LocalIcon.xCircle.path))
                              ],
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(
                                  offset: Offset(5, 10),
                                  blurRadius: 30,
                                  color: Color(0x40ffffff))
                            ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 14, 20, 20),
                              child: Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 36),
                                    child: AutoSizeText("Marcas",
                                        style: LocalTextStyle.emphasisText
                                            .copyWith(fontSize: 18)),
                                  ),
                                  Wrap(children: [
                                    for (var brand
                                        in optionsBrand.entries.toList())
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: AutoSizeText(
                                              brand.key,
                                              maxLines: 3,
                                              style: LocalTextStyle.bodyRegular
                                                  .copyWith(
                                                      color:
                                                          LocalColors.grisN100),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: Checkbox(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                value: brand.value,
                                                onChanged: (selected) {
                                                  setState(() {
                                                    optionsBrand[brand.key] =
                                                        selected ?? false;
                                                  });
                                                  setModalState(() {});
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ])
                                ],
                              ),
                            ),
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: FilledButton(
                                      text: "Filtrar (74 productos)",
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ]),
                          )
                        ],
                      );
                    });
                  });
            },
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
