import 'package:flutter/material.dart';
import 'package:prueba_dos/ui/components/label/label.dart';

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
        body: Center(
          child: SizedBox(
            height: 30,
            width: 93,
            child: Label(
                text: "Pruebas labels",
                onTap: (select) {
                  print(select);
                }),
          ),
        ),
      ),
    );
  }
}
