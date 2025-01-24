import 'package:currency_country_picker/src/country_list_view.dart';
import 'package:flutter/material.dart';

import '../currency_country_picker.dart';

Widget _builder({
  required BuildContext context,
  required ValueChanged<Country> onSelect,
  CountryPickerThemeData? theme,
  List<String>? countryFilter,
  List<String>? favorites,
  required bool showFlag,
  required bool showSearchField,
  required bool showPhoneCode,
  required bool showCountryName,
}) {
  final device = MediaQuery.sizeOf(context).height;

  return Dialog(
    shape: ContinuousRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    backgroundColor: theme?.backgroundColor,
    child: SizedBox(
      height: theme?.dialogHeight ?? device * .8,
      child: CountryListView(
        onSelect: onSelect,
        theme: theme,
        countryFilter: countryFilter,
        favorites: favorites,
        showFlag: showFlag,
        showCountryName: showCountryName,
        showPhone: showPhoneCode,
        showSearchField: showSearchField,
      ),
    ),
  );
}

void showCountryListDialog({
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
  showDialog(
    context: context,
    builder: (_) => _builder(
      context: context,
      onSelect: onSelect,
      favorites: favorites,
      countryFilter: countryFilter,
      theme: theme,
      showFlag: showFlag ?? true,
      showSearchField: showSearchField ?? true,
      showCountryName: showCountryName ?? true,
      showPhoneCode: showPhoneCode ?? true,
    ),
  );
}
