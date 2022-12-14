import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prueba_dos/ui/resources/color/color.dart';
import 'package:prueba_dos/ui/resources/icon/path_icon.dart';
import 'package:prueba_dos/ui/resources/style/text_style.dart';


///Boton que al darle click muestra dos iconos para agregar y restar
class AddButton extends StatefulWidget {
  const AddButton(
      {Key? key,
      required this.text,
      this.heightButton = 32,
      this.initialCount = 0,
      this.plusBtnOnPressed,
      this.minusBtnOnPressed})
      : super(key: key);

  ///Texto que se mostrara en el boton
  final String text;

  ///Altura del boton por defecto en 32
  final double heightButton;

  ///El numero inicial del contador del boton, por defecto en 0, si envias
  ///1 o mayor el boton mostrara los botones meno y mas, mostrando
  ///el numero de [initialCount]
  final int initialCount;

  ///Funcion que sera ejecutara cada vez que se de click en agregar
  ///un item
  final void Function()? plusBtnOnPressed;

  ///Funcion que sera ejecutara cada vez que se de click en restar
  ///un item
  final void Function()? minusBtnOnPressed;

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
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
                  const EdgeInsets.symmetric(vertical: 1, horizontal: 3))
              : null,
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))),
          textStyle: MaterialStateProperty.all(
              LocalTextStyle.emphasisText.copyWith(color: LocalColors.white)),
          backgroundColor: MaterialStateProperty.all(LocalColors.greenV200)),
      onPressed: () {
        setState(() {
          if (count == 0) {
            widget.plusBtnOnPressed?.call();
            count = count + 1;
          }
        });
      },
      child: SizedBox(
        height: widget.heightButton,
        child: count == 0
            ? Padding(
                padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
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
                          widget.minusBtnOnPressed?.call();
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
