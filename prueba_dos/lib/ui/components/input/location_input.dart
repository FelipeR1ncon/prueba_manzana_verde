import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prueba_dos/ui/resources/color/color.dart';
import 'package:prueba_dos/ui/resources/icon/path_icon.dart';
import 'package:prueba_dos/ui/resources/style/text_style.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key, required this.hintText}) : super(key: key);

  final String hintText;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  bool hasFocus = false;
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
                  color: hasFocus ? LocalColors.grisN100 : LocalColors.grisN30,
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
                  height: 56,
                  child: TextFormField(
                    style: LocalTextStyle.bodyRegular,
                    onChanged: (text) {
                      setState(() {
                        currentText = text;
                      });
                    },
                    cursorColor: LocalColors.grisN100,
                    decoration: InputDecoration(
                      labelStyle: LocalTextStyle.bodyBold.copyWith(
                          color: hasFocus
                              ? LocalColors.grisN60
                              : LocalColors.grisN70,
                          fontSize: hasFocus ? 14 : 16),
                      contentPadding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                      labelText: widget.hintText,
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
              Visibility(
                visible: !hasFocus && currentText.isEmpty,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 12),
                  child: SizedBox(
                    height: 22,
                    width: 22,
                    child: SvgPicture.asset(
                      LocalIcon.search.path,
                      color: LocalColors.grisN50,
                      height: 22,
                      width: 22,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const SizedBox(
              width: 4,
            ),
            SizedBox(
              width: 16,
              height: 16,
              child: SvgPicture.asset(
                LocalIcon.location.path,
                color: LocalColors.verdeV200,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "Ubicación actual",
              style: LocalTextStyle.bodyRegular.copyWith(
                  decoration: TextDecoration.underline,
                  color: LocalColors.verdeV200),
            )
          ],
        )
      ],
    );
  }
}
