import 'package:currency_country_picker/src/model/currency.dart';
import 'package:currency_country_picker/src/theme/currency_picker_theme_data.dart';
import 'package:flutter/material.dart';

import 'currency_list_view.dart';

Widget _builder({
  required BuildContext context,
  required ValueChanged<Currency> onSelect,
  CurrencyPickerThemeData? theme,
  List<String>? currencyFilter,
  List<String>? favorites,
  required bool showFlag,
  required bool showCurrencyName,
  required bool showCurrencyCode,
  required bool showSearchField,
}) {
  final device = MediaQuery.sizeOf(context).height;
  final statusBarHeight = MediaQuery.paddingOf(context).top;
  final height = device - (statusBarHeight + (kToolbarHeight));

  return SizedBox(
    height: theme?.bottomSheetHeight ?? height * .8,
    child: CurrencyListView(
      onSelect: onSelect,
      theme: theme,
      currencyFilter: currencyFilter,
      favorites: favorites,
      showFlag: showFlag,
      showCurrencyName: showCurrencyName,
      showCurrencyCode: showCurrencyCode,
      showSearchField: showSearchField,
    ),
  );
}

void showCurrencyListBottomSheet({
  required BuildContext context,
  required ValueChanged<Currency> onSelect,
  CurrencyPickerThemeData? theme,
  List<String>? currencyFilter,
  List<String>? favorites,
  required bool showFlag,
  required bool showCurrencyName,
  required bool showCurrencyCode,
  required bool showSearchField,
}) {
  const ShapeBorder shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  );
  showModalBottomSheet(
    enableDrag: true,
    backgroundColor: theme?.backgroundColor,
    isScrollControlled: true,
    shape: shape,
    context: context,
    builder: (_) => _builder(
      context: context,
      onSelect: onSelect,
      theme: theme,
      favorites: favorites,
      currencyFilter: currencyFilter,
      showSearchField: showSearchField,
      showCurrencyCode: showCurrencyCode,
      showCurrencyName: showCurrencyName,
      showFlag: showFlag,
    ),
  );
}
