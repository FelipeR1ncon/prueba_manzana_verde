import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prueba_dos/ui/resources/color/color.dart';
import 'package:prueba_dos/ui/resources/icon/path_icon.dart';

import '../../resources/style/text_style.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    Key? key,
    required this.changeIndex,
  }) : super(key: key);

  final Function(int) changeIndex;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.changeIndex.call(0);
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        LocalIcon.leaftFill.path,
                        color: selectedIndex == 1
                            ? LocalColors.grisN50
                            : LocalColors.grisN100,
                        width: 14,
                        height: 12,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text("Comidas",
                          style: LocalTextStyle.bodyBold.copyWith(
                              color: selectedIndex == 1
                                  ? LocalColors.grisN50
                                  : LocalColors.grisN100))
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.changeIndex.call(1);
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(children: [
                        Image.asset(
                          LocalIcon.homaStart.path,
                          color: selectedIndex == 1
                              ? LocalColors.grisN100
                              : LocalColors.grisN50,
                          width: 18,
                          height: 16,
                        ),
                        Image.asset(
                            LocalIcon.start.path,
                            color: selectedIndex == 1
                                ? const Color(0xFFCF44A8)
                                : const Color(0xADCF44A8),
                            width: 16,
                            height: 18,
                          ),

                      ]),
                      const SizedBox(
                        height: 6,
                      ),
                      Text("Market",
                          style: LocalTextStyle.bodyBold.copyWith(
                              color: selectedIndex == 1
                                  ? LocalColors.grisN100
                                  : LocalColors.grisN50))
                    ],
                  ),
                )
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [SvgPicture.asset(LocalIcon.homeIndicator.path)]),
          ],
        ));
  }
}
