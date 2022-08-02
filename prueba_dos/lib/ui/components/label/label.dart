import 'package:flutter/material.dart';
import 'package:prueba_dos/ui/resources/color/color.dart';

class Label extends StatefulWidget {
  ///Obligatorio,texto que se mostrara en la chip
  final String text;

  ///Opcional, bandera para el estado inicial de la chip si este es true la chip
  ///usara los colores del estado seleccionado.
  final bool initialIsSelected;

  ///Opcional, color que se usa cuando la chip esta selecionada o cuando se pasa
  ///[initialIsSelected] en true
  final Color selectedBackgroundColor;

  ///Opcional, color que se usa cuando para el fondo de la chip
  ///cuando no esta seleccionada.
  final Color defaultBackgroundtColor;

  ///Opcional, color que se usa para el borde
  ///cuando la chip no esta seleccionada.
  final Color borderDefaultColor;

  ///Opcional, color que se usa para el borde
  ///cuando la chip esta selecionada o cuando se pasa [initialIsSelected]
  ///en true.
  final Color borderSelectedColor;

  ///Opcional, color que se usa para el texto
  ///cuando la chip esta selecionada o cuando se pasa [initialIsSelected]
  ///en true.
  final Color selectedTextColor;

  ///Opcional, color que se usa para el texto
  ///cuando la chip no esta seleccionada.
  final Color defaultTextColor;

  ///Opcional, funcion para manejar el click en el chip.
  final void Function(bool)? onTap;

  const Label(
      {Key? key,
      required this.text,
      this.initialIsSelected = false,
      this.selectedBackgroundColor = LocalColors.grisN100,
      this.defaultBackgroundtColor = LocalColors.blanco,
      this.borderDefaultColor = LocalColors.grisN40,
      this.borderSelectedColor = LocalColors.grisN100,
      this.selectedTextColor = LocalColors.blanco,
      this.defaultTextColor = LocalColors.grisN70,
      this.onTap})
      : super(key: key);

  @override
  State<Label> createState() => _LabelState();
}

class _LabelState extends State<Label> {
  ///Variable de estado para intercambiar entre seleccionao y no
  ///seleccionado, cada vez que se le da click al componente
  ///esta variable cambia.
  late bool isSelected;

  ///Variables para los colores del componente que se configuran
  ///segun [isSelected]
  late Color backgroundColor;
  late Color borderColor;
  late TextStyle textStyle;

  @override
  void initState() {
    super.initState();
    isSelected = widget.initialIsSelected;
    configState(isSelected);
  }

  ///Configurar los colores del componente segun si este se encuentra en estado
  ///seleccionado o no.
  void configState(bool isSelected) {
    if (isSelected) {
      backgroundColor = widget.selectedBackgroundColor;
      borderColor = widget.borderSelectedColor;
      textStyle = TextStyle(color: widget.selectedTextColor);
    } else {
      backgroundColor = widget.defaultBackgroundtColor;
      borderColor = widget.borderDefaultColor;
      textStyle = TextStyle(color: widget.defaultTextColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!.call(!isSelected);
          }
          setState(() {
            isSelected = !isSelected;
            configState(isSelected);
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(width: 1, color: borderColor),
            borderRadius: BorderRadius.circular(48),
          ),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              child: Text(widget.text, style: textStyle)),
        ));
  }
}
