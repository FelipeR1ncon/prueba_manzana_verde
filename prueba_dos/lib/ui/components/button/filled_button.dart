import 'package:flutter/material.dart';
import 'package:prueba_dos/ui/resources/style/text_style.dart';

import '../../resources/color/color.dart';

///Boton sencillo con el estilo de boton primario de la app
class FilledButton extends StatelessWidget {
  const FilledButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.heightButton = 40})
      : super(key: key);

  final double heightButton;
  final String text;

  ///Funcion que se llama al dale click al boton
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32))),
            textStyle: MaterialStateProperty.all(
                LocalTextStyle.emphasisText.copyWith(color: LocalColors.white)),
            backgroundColor: MaterialStateProperty.all(LocalColors.greenV200)),
        onPressed: () => onPressed.call(),
        child: Center(
            child: Text(text,
                style: LocalTextStyle.emphasisText,
                textAlign: TextAlign.center)));
  }
}
