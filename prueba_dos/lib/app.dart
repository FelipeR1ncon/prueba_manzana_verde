import 'package:flutter/material.dart';
import 'package:prueba_dos/ui/components/card/product_card.dart';
import 'package:prueba_dos/ui/components/input/input_search.dart';
import 'package:prueba_dos/ui/components/input/location_input.dart';
import 'package:prueba_dos/ui/components/label/label.dart';
import 'package:prueba_dos/ui/resources/images/path_images.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("data")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            const SearchInput(placeHolder: "Buscar en market"),
            const SizedBox(
              height: 20,
            ),
            const LocationInput(
              hintText: "Dirección",
            ),
            const SizedBox(
              height: 20,
            ),
            ProductCard(
                productImagePath: LocalImage.product1.path,
                productName: "Almendra Cubierta en Chocolate - Gozana",
                productMeasurement: "12 gr",
                productBrand: "Gozana",
                normalPrice: "S/ 15.00",
                offerPrice: "S/ 19.00"),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 30,
              width: 93,
              child: Label(
                  text: "Pruebas labels",
                  onTap: (select) {
                    print(select);
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }
}
