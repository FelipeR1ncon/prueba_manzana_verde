import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prueba_dos/ui/resources/color/color.dart';
import 'package:prueba_dos/ui/resources/icon/path_icon.dart';
import 'package:prueba_dos/ui/resources/style/text_style.dart';

class FilledButton extends StatefulWidget {
  const FilledButton(
      {Key? key,
      required this.text,
      this.heightButton = 32,
      this.initialCount = 0,
      this.plusBtnOnPressed,
      this.minuBtnOnPressed})
      : super(key: key);

  ///Texto que se mostrara en el boton
  final String text;
  final double heightButton;
  final int initialCount;

  ///Funcion que sera ejecutara cada vez que se de click en agregar o sumar
  ///un item
  final void Function()? plusBtnOnPressed;

  final void Function()? minuBtnOnPressed;

  @override
  State<FilledButton> createState() => _FilledButtonState();
}

class _FilledButtonState extends State<FilledButton> {
  late int count;

  @override
  void initState() {
    super.initState();
    count = widget.initialCount;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          fixedSize: count > 0
              ? MaterialStateProperty.all(const Size.fromWidth(128))
              : null,
          padding: count > 0
              ? MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 2, horizontal: 2))
              : null,
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))),
          textStyle: MaterialStateProperty.all(
              LocalTextStyle.emphasisText.copyWith(color: LocalColors.white)),
          backgroundColor: MaterialStateProperty.all(LocalColors.verdeV200)),
      onPressed: () {
        widget.plusBtnOnPressed?.call();
        setState(() {
          count = count + 1;
        });
      },
      child: SizedBox(
        height: widget.heightButton,
        child: count == 0
            ? Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(widget.text,
                    style: LocalTextStyle.emphasisText,
                    textAlign: TextAlign.center),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                    GestureDetector(
                        onTap: () {
                          widget.minuBtnOnPressed?.call();
                          setState(() {
                            count = count - 1;
                          });
                        },
                        child: SvgPicture.asset(LocalIcon.minusBtn.path)),
                    AutoSizeText(
                      count.toString(),
                      maxLines: 1,
                      maxFontSize: 30,
                      style: LocalTextStyle.emphasisText.copyWith(fontSize: 15),
                    ),
                    GestureDetector(
                        onTap: () {
                          widget.plusBtnOnPressed?.call();
                          setState(() {
                            count = count + 1;
                          });
                        },
                        child: SvgPicture.asset(
                          LocalIcon.plusBtn.path,
                        )),
                  ]),
      ),
    );
  }
}
