import 'package:flutter/material.dart';
import 'package:prueba_dos/ui/resources/style/text_style.dart';

import '../../resources/color/color.dart';

class FilledButton extends StatelessWidget {
  const FilledButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.heightButton = 40})
      : super(key: key);

  final String text;
  final Function() onPressed;
  final double heightButton;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32))),
            textStyle: MaterialStateProperty.all(
                LocalTextStyle.emphasisText.copyWith(color: LocalColors.white)),
            backgroundColor: MaterialStateProperty.all(LocalColors.verdeV200)),
        onPressed: () => onPressed.call(),
        child: Center(
            child: Text(text,
                style: LocalTextStyle.emphasisText,
                textAlign: TextAlign.center)));
  }
}
