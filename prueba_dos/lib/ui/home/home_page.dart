import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prueba_dos/ui/components/card/filter_card.dart';
import 'package:prueba_dos/ui/components/card/product/product_card.dart';
import 'package:prueba_dos/ui/components/card/product/product_model.dart';
import 'package:prueba_dos/ui/components/label/label.dart';

import 'package:prueba_dos/ui/resources/color/color.dart';
import 'package:prueba_dos/ui/resources/icon/path_icon.dart';
import 'package:prueba_dos/ui/resources/images/path_images.dart';
import 'package:prueba_dos/ui/resources/style/text_style.dart';

import '../components/input/search_input.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> labels = [
    "Etiqueta a",
    "Etiqueta bc",
    "Snacks",
    "Etiqueta b"
  ];

  final List<ProductUIModel> products = [
    ProductUIModel(
        productImagePath: LocalImage.product1.path,
        productName: "Almendra Cubierta en Chocolate - Gozana",
        productMeasurement: "12 gr",
        productBrand: "Gozana",
        normalPrice: "S/ 15.00",
        offerPrice: "S/ 19.00"),
    ProductUIModel(
        productImagePath: LocalImage.product2.path,
        productName: "Garbanzos Horneados Ajo y Cebolla - Gozana",
        productMeasurement: "90 gr",
        productBrand: "Gozana Snacks",
        normalPrice: "S/. 11.00"),
    ProductUIModel(
        productImagePath: LocalImage.product1.path,
        productName: "Almendra Cubierta en Chocolate - Gozana",
        productMeasurement: "12 gr",
        productBrand: "Gozana",
        normalPrice: "S/ 15.00",
        offerPrice: "S/ 19.00"),
    ProductUIModel(
        productImagePath: LocalImage.product2.path,
        productName: "Garbanzos Horneados Ajo y Cebolla - Gozana",
        productMeasurement: "90 gr",
        productBrand: "Gozana Snacks",
        normalPrice: "S/. 11.00"),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const HeaderHome(),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 24, 12, 12),
              child: Text(
                "Snack",
                style: LocalTextStyle.titleText.copyWith(fontSize: 32),
              ),
            ),
            const CardFilter(),
            const SizedBox(
              height: 21,
            ),
            LabelFilter(labels: labels),
            const SizedBox(
              height: 24,
            ),
            Expanded(
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
            ),
          ]),
        ),
        bottomNavigationBar: SizedBox(
            height: 80,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          LocalIcon.leaftFill.path,
                          width: 14,
                          height: 12,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text("Comidas",
                            style: LocalTextStyle.bodyBold
                                .copyWith(color: LocalColors.grisN100))
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(children: [
                          SvgPicture.asset(
                            LocalIcon.homaStart.path,
                            width: 18,
                            height: 16,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: SvgPicture.asset(
                              LocalIcon.start.path,
                              color: const Color(0xFFCF44A8),
                              width: 16,
                              height: 18,
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 6,
                        ),
                        Text("Market",
                            style: LocalTextStyle.bodyBold
                                .copyWith(color: LocalColors.grisN100))
                      ],
                    )
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [SvgPicture.asset(LocalIcon.homeIndicator.path)]),
              ],
            )));
  }
}

class CardFilter extends StatelessWidget {
  const CardFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 8,
              child: FilterCard(
                  pathIcon: LocalIcon.arrowSwap.path, text: "Ordenar")),
          const Spacer(
            flex: 1,
          ),
          Expanded(
              flex: 8,
              child: FilterCard(
                pathIcon: LocalIcon.chevronLeft.path,
                text: "Marcas",
                showNotificationPoint: true,
              )),
        ],
      ),
    );
  }
}

class LabelFilter extends StatelessWidget {
  const LabelFilter({
    Key? key,
    required this.labels,
  }) : super(key: key);

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: SizedBox(
        height: 32,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            for (var item in labels)
              Row(children: [
                Label(
                  text: item,
                  initialIsSelected: "Snacks" == item,
                ),
                const SizedBox(
                  width: 8,
                )
              ])
          ],
        ),
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
