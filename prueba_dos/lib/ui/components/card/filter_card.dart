import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prueba_dos/ui/resources/color/color.dart';
import 'package:prueba_dos/ui/resources/style/text_style.dart';

///Card para mostrar chip de filtros
class FilterCard extends StatelessWidget {
  const FilterCard(
      {Key? key,
      required this.pathIcon,
      required this.text,
      this.showNotificationPoint = false})
      : super(key: key);

  ///Icono que se mostrara a la derecha del texto
  final String pathIcon;

  ///Texto para indicar que filtro es
  final String text;

  ///Opcional, si esta variable esta en true se mostrara una burbuja de notificacion
  ///en la parte superior derecha del texto
  final bool showNotificationPoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 12),
      decoration: const BoxDecoration(
          color: LocalColors.grayN20,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(text,
              style: LocalTextStyle.bodyRegular.copyWith(color: Colors.black)),
          Visibility(
              visible: showNotificationPoint,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: CircleAvatar(
                      radius: 3.1416,
                      backgroundColor: LocalColors.greenV200,
                    ),
                  )
                ],
              )),
          const SizedBox(
            width: 10,
          ),
          SvgPicture.asset(pathIcon)
        ],
      ),
    );
  }
}
