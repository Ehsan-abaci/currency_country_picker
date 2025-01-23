import 'package:flutter/material.dart';

class CurrencyPickerThemeData {
  final ShapeBorder? shape;

  /// The currency background color.
  final Color? backgroundColor;

  ///The style to use for title text.
  ///
  /// If null, the style will be set to [TextStyle(fontSize: 17)]
  final TextStyle? titleTextStyle;

  ///The style to use for subtitle text.
  ///
  /// If null, the style will be set to [TextStyle(fontSize: 15, color: Theme.of(context).hintColor)]
  final TextStyle? subtitleTextStyle;

  /// If null, the style will be set to [TextStyle(fontSize: 18);]
  final TextStyle? currencySignTextStyle;

  ///The decoration used for the search field
  ///
  /// It defaults to a basic outline-bordered input decoration
  final InputDecoration? inputDecoration;

  ///The flag size.
  ///
  /// If null, set to 25
  final double? flagSize;

  ///Country list modal height
  ///
  /// By default it's fullscreen
  final double? bottomSheetHeight;

  CurrencyPickerThemeData({
    this.shape,
    this.backgroundColor,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.currencySignTextStyle,
    this.inputDecoration,
    this.flagSize,
    this.bottomSheetHeight,
  });
}
