import 'package:flutter/material.dart';

class CountryPickerThemeData {
  /// The country background color.
  final Color? backgroundColor;

  ///The style to use for title text.
  ///
  /// If null, the style will be set to [TextStyle(fontSize: 16)]
  final TextStyle? titleTextStyle;

  /// If null, the style will be set to [TextStyle(fontSize: 16);]
  final TextStyle? countryCodeTextStyle;

  /// If null, the style will be set to [TextStyle(fontSize: 20);]
  final TextStyle? searchTextStyle;

  ///The decoration used for the search field
  ///
  /// It defaults to a basic outline-bordered input decoration
  final InputDecoration? inputDecoration;

  ///The flag size.
  ///
  /// If null, set to 25
  final double? flagSize;

  final double? dialogHeight;

  CountryPickerThemeData({
    this.backgroundColor,
    this.titleTextStyle,
    this.searchTextStyle,
    this.countryCodeTextStyle,
    this.inputDecoration,
    this.flagSize,
    this.dialogHeight,
  });
}
