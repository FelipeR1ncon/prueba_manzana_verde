import 'package:flutter/material.dart';
import 'package:prueba_dos/ui/components/card/product/product_model.dart';
import 'package:prueba_dos/ui/home/widgets/export.dart';
import 'package:prueba_dos/ui/resources/images/path_images.dart';
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
        normalPrice: "S/ 15.00",
        offerPrice: "S/ 19.00"),
    ProductUIModel(
        productImagePath: LocalImage.product4.path,
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
            GridProduct(products: products),
          ]),
        ),
        bottomNavigationBar: NavBar(
          changeIndex: (newIndex) {
            _onItemTapped(newIndex);
          },
        ));
  }
}
