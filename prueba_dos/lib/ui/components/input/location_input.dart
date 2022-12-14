import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prueba_dos/ui/resources/color/color.dart';
import 'package:prueba_dos/ui/resources/icon/path_icon.dart';
import 'package:prueba_dos/ui/resources/style/text_style.dart';

class LocationInput extends StatefulWidget {
  const LocationInput(
      {Key? key,
      required this.hintText,
      this.onTapSearch,
      this.onChangeText,
      required this.controller})
      : super(key: key);

  ///Texto para indicarle al usuario que debe de ingresar en el campo
  final String hintText;

  ///Funcion que se ejecuta cuando se da click en el seccion del icono de buscar
  final void Function()? onTapSearch;

  ///Funcion que se ejecuta cada vez que cambia el texto del input
  final void Function(String)? onChangeText;

  final TextEditingController controller;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  ///Bandera para manejar el estado del foco del componente y pintar los
  ///componentes adecuados en cada estado
  bool hasFocus = false;

  ///Texto actual del componente se usa para esconder el icono cuando el componente
  ///no esta vacio
  String currentText = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: hasFocus ? LocalColors.grayN100 : LocalColors.grayN30,
                  width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Focus(
            onFocusChange: (haveFocus) {
              hasFocus = haveFocus;
              setState(() {});
            },
            child: Row(children: [
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: TextFormField(
                    controller: widget.controller,
                    style: LocalTextStyle.bodyRegular
                        .copyWith(color: LocalColors.grayN100),
                    onChanged: (text) {
                      if (widget.onChangeText != null) {
                        widget.controller.text = text;
                        widget.onChangeText!(text);
                      }

                      setState(() {
                        currentText = text;
                      });
                    },
                    cursorColor: LocalColors.grayN100,
                    decoration: InputDecoration(
                      isDense: false,
                      labelStyle: LocalTextStyle.bodyBold.copyWith(
                          color: hasFocus || currentText.isNotEmpty
                              ? LocalColors.grayN60
                              : LocalColors.grayN70,
                          fontSize:
                              hasFocus || currentText.isNotEmpty ? 14 : 16),
                      contentPadding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
                      labelText: widget.hintText,
                      hintStyle: LocalTextStyle.bodyRegular
                          .copyWith(color: LocalColors.grayN70),
                      alignLabelWithHint: true,
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTapCancel: () => widget.onTapSearch?.call(),
                child: Visibility(
                  visible: !hasFocus && currentText.isEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10, right: 12),
                    child: SizedBox(
                      height: 22,
                      width: 22,
                      child: SvgPicture.asset(
                        LocalIcon.search.path,
                        color: LocalColors.grayN50,
                        height: 22,
                        width: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () {
            setState(() {
              widget.controller.text = "Armenia, Quind??o";
            });
          },
          child: Row(
            children: [
              const SizedBox(
                width: 4,
              ),
              SizedBox(
                width: 22,
                height: 22,
                child: SvgPicture.asset(
                  LocalIcon.gpsPoint.path,
                  color: LocalColors.greenV200,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Ubicaci??n actual",
                style: LocalTextStyle.bodyRegular.copyWith(
                    decoration: TextDecoration.underline,
                    color: LocalColors.greenV200),
              )
            ],
          ),
        )
      ],
    );
  }
}
