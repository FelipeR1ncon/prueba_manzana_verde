import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  ///Place holder que se mostrara en el input del componente
  final String placeHolder;

  ///Funcion que se ejecuta cuando se da clicl en el seccion del icono de buscar
  final void Function(String)? onTapSearch;

  ///
  final void Function()? onTapExit;

  const SearchInput(
      {Key? key, required this.placeHolder, this.onTapSearch, this.onTapExit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [],
    );
  }
}
