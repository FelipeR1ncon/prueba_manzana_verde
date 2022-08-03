import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prueba_dos/ui/resources/color/color.dart';
import 'package:prueba_dos/ui/resources/icon/path_icon.dart';
import 'package:prueba_dos/ui/resources/style/text_style.dart';

class FilterCard extends StatelessWidget {
  const FilterCard(
      {Key? key,
      required this.pathIcon,
      required this.text,
      this.notificationoint = false})
      : super(key: key);

  final String pathIcon;
  final String text;
  final bool notificationoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 12),
      decoration: const BoxDecoration(
          color: LocalColors.grisN20,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: LocalTextStyle.bodyRegular,
          ),
          const SizedBox(
            width: 10,
          ),
          SvgPicture.asset(pathIcon)
        ],
      ),
    );
  }
}
