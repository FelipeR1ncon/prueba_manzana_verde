import 'package:flutter/material.dart';
import 'package:prueba_dos/ui/resources/color/color.dart';
import 'package:prueba_dos/ui/resources/style/text_style.dart';

class FilledButton extends StatelessWidget {
  const FilledButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.heightButton = 32})
      : super(key: key);

  ///Texto que se mostrara en el boton
  final String text;

  final double heightButton;

  ///Funcion que sera ejecutara cada vez que se de click en el boton
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))),
          textStyle: MaterialStateProperty.all(
              LocalTextStyle.emphasisText.copyWith(color: LocalColors.white)),
          backgroundColor: MaterialStateProperty.all(LocalColors.verdeV200)),
      onPressed: onPressed,
      child: Container(
        height: heightButton,
        decoration: BoxDecoration(
          color: LocalColors.verdeV200,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(text,
                style: LocalTextStyle.emphasisText,
                textAlign: TextAlign.center)),
      ),
    );
  }
}
