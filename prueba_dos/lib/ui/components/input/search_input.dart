import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prueba_dos/ui/resources/color/color.dart';
import 'package:prueba_dos/ui/resources/icon/path_icon.dart';
import 'package:prueba_dos/ui/resources/style/text_style.dart';

class SearchInput extends StatelessWidget {
  ///Place holder que se mostrara en el input del componente
  final String placeHolder;

  ///Funcion que se ejecuta cuando se da click en el seccion del icono de buscar
  final void Function()? onTapSearch;

  ///Funcion que se ejecuta cada vez que cambia el texto del input
  final void Function(String)? onChangeText;

  ///Function que se ejecuta cuando se da click en el icono de la flecha de
  ///salida
  final void Function()? onTapExit;

  const SearchInput(
      {Key? key,
      required this.placeHolder,
      this.onTapSearch,
      this.onTapExit,
      this.onChangeText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => onTapExit?.call(),
          child: Container(
            color: Colors.transparent,
            child: SvgPicture.asset(
              LocalIcon.arrowExit.path,
              color: LocalColors.verdeV200,
              height: 20,
              width: 20,
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: SizedBox(
            height: 32,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    topLeft: Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0D909390),
                    blurRadius: 0.45,
                    offset: Offset(0, 0.18),
                  ),
                  BoxShadow(
                    color: Color(0x1A909390),
                    blurRadius: 1.25,
                    offset: Offset(0, 0.45),
                  ),
                  BoxShadow(
                    color: Color(0x26909390),
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                  BoxShadow(
                    color: Color(0x33909390),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextFormField(
                style: LocalTextStyle.bodyRegular
                    .copyWith(color: LocalColors.grisN100),
                onChanged: (text) {
                  if (onChangeText != null) {
                    onChangeText!(text);
                  }
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(12, 6, 6, 2),
                  focusedBorder: null,
                  focusColor: LocalColors.white,
                  filled: true,
                  fillColor: LocalColors.white,
                  hintText: placeHolder,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        topLeft: Radius.circular(8)),
                  ),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => onTapSearch?.call(),
          child: Container(
            width: 48,
            height: 32,
            decoration: const BoxDecoration(
              color: LocalColors.verdeV200,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  topRight: Radius.circular(8)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                LocalIcon.search.path,
                height: 18,
                width: 18,
              ),
            ),
          ),
        )
      ],
    );
  }
}
