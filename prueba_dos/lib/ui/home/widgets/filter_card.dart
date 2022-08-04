import 'package:flutter/material.dart';
import 'package:prueba_dos/ui/components/card/filter_card.dart';
import 'package:prueba_dos/ui/resources/icon/path_icon.dart';

class CardFilter extends StatelessWidget {
  const CardFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 8,
              child: FilterCard(
                  pathIcon: LocalIcon.arrowSwap.path, text: "Ordenar")),
          const Spacer(
            flex: 1,
          ),
          Expanded(
              flex: 8,
              child: FilterCard(
                pathIcon: LocalIcon.chevronLeft.path,
                text: "Marcas",
                showNotificationPoint: true,
              )),
        ],
      ),
    );
  }
}
