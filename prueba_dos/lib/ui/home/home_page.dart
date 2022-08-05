import 'package:flutter/material.dart';
import 'package:prueba_dos/ui/components/card/product/product_model.dart';
import 'package:prueba_dos/ui/home/widgets/export.dart';
import 'package:prueba_dos/ui/resources/image/path_images.dart';
import 'package:prueba_dos/ui/resources/style/text_style.dart';

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
        productImagePath: LocalImage.product3.path,
        productName: "Almendra Cubierta en Chocolate - Gozana",
        productMeasurement: "12 gr",
        productBrand: "Gozana",
        normalPrice: "S/ 15.00"),
    ProductUIModel(
        productImagePath: LocalImage.product4.path,
        productName: "Garbanzos Horneados Ajo y Cebolla - Gozana",
        productMeasurement: "90 gr",
        productBrand: "Gozana Snacks",
        normalPrice: "S/. 11.00"),
  ];

  // ignore: unused_field
  int _selectedIndex = 0;
  int _quantitiesProducts = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addedProduct() {
    setState(() {
      _quantitiesProducts = _quantitiesProducts + 1;
    });
  }

  void _subtractProduct() {
    setState(() {
      _quantitiesProducts = _quantitiesProducts - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            HeaderHome(quantitiesProducts: _quantitiesProducts),
            Padding(
              padding: MediaQuery.of(context).size.height > 550
                  ? const EdgeInsets.fromLTRB(12, 24, 12, 12)
                  : const EdgeInsets.fromLTRB(12, 9, 12, 8),
              child: Text(
                "Snack",
                style: LocalTextStyle.titleText.copyWith(
                    fontSize:
                        MediaQuery.of(context).size.height > 550 ? 32 : 22),
              ),
            ),
            const CardFilter(),
            SizedBox(
              height: MediaQuery.of(context).size.height > 550 ? 21 : 8,
            ),
            LabelFilter(labels: labels),
            SizedBox(
              height: MediaQuery.of(context).size.height > 550 ? 21 : 8,
            ),
            GridProduct(
              products: products,
              minusBtnOnPressed: () => _subtractProduct(),
              plusBtnOnPressed: () => _addedProduct(),
            ),
          ]),
        ),
        bottomNavigationBar: NavBar(
          changeIndex: (newIndex) {
            _onItemTapped(newIndex);
          },
        ),
        resizeToAvoidBottomInset: false);
  }
}
