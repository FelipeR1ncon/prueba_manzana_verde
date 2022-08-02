import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocalTextStyle {
  static const double _sizeGigantTitle = 32;
  static const double _sizeNormalTitle = 24;
  static const double _sizeEmphasis = 16;
  static const double _sizeNormalBody = 14;
  static const double _sizeSmallBody = 12;

  static const String fontFamilyAxiforma = 'Axiforma';

  static const TextStyle emphasisText = TextStyle(
      fontFamily: fontFamilyAxiforma,
      height: 1.5,
      fontSize: _sizeEmphasis,
      fontWeight: FontWeight.w800);

  static const TextStyle titleText = TextStyle(
      fontFamily: fontFamilyAxiforma,
      height: 1.25,
      fontSize: _sizeNormalTitle,
      fontWeight: FontWeight.w700);

  static const TextStyle bodyBold = TextStyle(
      fontFamily: fontFamilyAxiforma,
      height: 1.5,
      fontSize: _sizeSmallBody,
      fontWeight: FontWeight.w600);

  static const TextStyle bodyRegular = TextStyle(
      fontFamily: fontFamilyAxiforma,
      height: 1.5,
      fontSize: _sizeNormalBody,
      fontWeight: FontWeight.w300);
}
