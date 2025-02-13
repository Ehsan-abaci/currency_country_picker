library currency_country_picker;

import 'package:currency_country_picker/src/country_list_dialog.dart';
import 'package:flutter/material.dart';

import 'currency_country_picker.dart';
import 'src/country_screen.dart';
import 'src/currency_list_bottom_sheet.dart';

export 'package:currency_country_picker/src/model/country.dart';
export 'package:currency_country_picker/src/model/currency.dart';
export 'package:currency_country_picker/src/services/country_service.dart';
export 'package:currency_country_picker/src/services/currency_service.dart';
export 'package:currency_country_picker/src/theme/country_picker_theme_data.dart';
export 'package:currency_country_picker/src/theme/currency_picker_theme_data.dart';

void showCountryPickerFullScreen({
  required BuildContext context,
  required ValueChanged<Country> onSelect,
  CountryPickerThemeData? theme,
  bool? showFlag,
  List<String>? countryFilter,
  List<String>? favorites,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CountryScreen(
        onSelect: onSelect,
        theme: theme,
        countryFilter: countryFilter,
        favorites: favorites,
      ),
    ),
  );
}

void showCurrencyPickerBottomSheet({
  required BuildContext context,
  required ValueChanged<Currency> onSelect,
  CurrencyPickerThemeData? theme,
  List<String>? currencyFilter,
  List<String>? favorites,
  bool? showFlag,
  bool? showCurrencyName,
  bool? showCurrencyCode,
  bool? showSearchField,
}) {
  showCurrencyListBottomSheet(
    context: context,
    onSelect: onSelect,
    theme: theme,
    currencyFilter: currencyFilter,
    favorites: favorites,
    showCurrencyCode: showCurrencyCode ?? true,
    showCurrencyName: showCurrencyName ?? true,
    showFlag: showFlag ?? true,
    showSearchField: showSearchField ?? true,
  );
}

void showCountryPickerDialog({
  required BuildContext context,
  required ValueChanged<Country> onSelect,
  CountryPickerThemeData? theme,
  bool? showFlag,
  bool? showPhoneCode,
  bool? showCountryName,
  bool? showSearchField,
  List<String>? countryFilter,
  List<String>? favorites,
}) {
  showCountryListDialog(
    context: context,
    theme: theme,
    onSelect: onSelect,
    showPhoneCode: showPhoneCode,
    showFlag: showFlag,
    showCountryName: showCountryName,
    showSearchField: showSearchField,
    countryFilter: countryFilter,
    favorites: favorites,
  );
}
