import 'package:flutter/material.dart';
import 'package:prueba_dos/ui/resources/color/color.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: LocalColors.grisN20,
        ),
      ),
    );
  }
}
