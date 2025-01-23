import 'package:currency_country_picker/src/services/currency_service.dart';
import 'package:currency_country_picker/src/theme/currency_picker_theme_data.dart';
import 'package:flutter/material.dart';

import 'model/currency.dart';

class CurrencyListView extends StatefulWidget {
  /// Called when a currency is select.
  ///
  /// The currency picker passes the new value to the callback.
  final ValueChanged<Currency> onSelect;

  /// The Currencies that will appear at the top of the list (optional).
  ///
  /// It takes a list of Currency code.
  final List<String>? favorites;

  /// Can be used to uses filter the Currency list (optional).
  ///
  /// It takes a list of Currency code.
  final List<String>? currencyFilter;

  /// Shows flag for each currency (optional).
  ///
  /// Defaults true.
  final bool showFlag;

  /// Shows currency name (optional).
  /// [showCurrencyName] and [showCurrencyCode] cannot be both false
  ///
  /// Defaults true.
  final bool showCurrencyName;

  /// Shows currency code (optional).
  /// [showCurrencyCode] and [showCurrencyName] cannot be both false
  ///
  /// Defaults true.
  final bool showCurrencyCode;

  /// To disable the search TextField (optional).
  final bool showSearchField;

  /// Hint of the search TextField (optional).
  ///
  /// Defaults Search.
  final String? searchHint;

  /// Scroll controller (optional).
  final ScrollController? controller;

  /// Scroll physics (optional).
  final ScrollPhysics? physics;

  /// Theme data (optional).
  final CurrencyPickerThemeData? theme;

  const CurrencyListView({
    super.key,
    required this.onSelect,
    this.favorites,
    this.currencyFilter,
    required this.showFlag,
    required this.showCurrencyName,
    required this.showCurrencyCode,
    required this.showSearchField,
    this.searchHint,
    this.controller,
    this.physics,
    this.theme,
  }) : assert(currencyFilter == null || favorites == null);

  @override
  State<CurrencyListView> createState() => _CurrencyListViewState();
}

class _CurrencyListViewState extends State<CurrencyListView> {
  final CurrencyService _currencyService = CurrencyService();

  late List<Currency> _filteredList;
  late List<Currency> _currencyList;
  List<Currency>? _favoriteList;

  TextEditingController? _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();

    _filteredList = <Currency>[];

    _currencyList = _currencyService.getAllCurrencies();

    if (widget.currencyFilter != null) {
      final List<String> currencyFilter =
          widget.currencyFilter!.map((code) => code.toUpperCase()).toList();
      _currencyList.removeWhere((currency) => !currencyFilter.contains(currency.code));
    }

    if (widget.favorites != null) {
      _favoriteList = _currencyService.findCurrenciesByCode(widget.favorites!);
    }

    _filteredList.addAll(_currencyList);

    super.initState();
  }

  @override
  void dispose() {
    _searchController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textFieldBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white.withOpacity(0.2),
      ),
    );

    return Column(
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: widget.showSearchField
              ? TextField(
                  controller: _searchController,
                  decoration: widget.theme?.inputDecoration ??
                      InputDecoration(
                        hintText: widget.searchHint ?? 'Search',
                        prefixIcon: const Icon(Icons.search),
                        border: textFieldBorder,
                        enabledBorder: textFieldBorder,
                        focusedBorder: textFieldBorder,
                      ),
                  onChanged: _filterSearchResults,
                )
              : Container(),
        ),
        Expanded(
          child: ListView(
            physics: widget.physics,
            controller: widget.controller,
            children: [
              if (_favoriteList != null) ...[
                ..._favoriteList!.map<Widget>((currency) => _listRow(currency)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(thickness: 1),
                ),
              ],
              ..._filteredList.map<Widget>((currency) => _listRow(currency)),
            ],
          ),
        ),
      ],
    );
  }

  _listRow(Currency currency) {
    return ListTile(
      onTap: () {
        widget.onSelect(currency);
        Navigator.pop(context);
      },
      minLeadingWidth: 30,
      contentPadding: const EdgeInsets.symmetric(horizontal: 25),
      leading: widget.showFlag
          ? Text(
              currency.emoji,
              style: TextStyle(fontSize: widget.theme?.flagSize ?? 18),
            )
          : null,
      title: widget.showCurrencyCode
          ? Text(
              currency.code,
              style: widget.theme?.titleTextStyle ?? const TextStyle(fontSize: 18),
            )
          : null,
      subtitle: widget.showCurrencyName
          ? Text(
              currency.name,
              style: widget.theme?.subtitleTextStyle ??
                  TextStyle(fontSize: 15, color: Theme.of(context).hintColor),
            )
          : null,
      trailing: Text(
        currency.symbol,
        style: widget.theme?.currencySignTextStyle ??
            const TextStyle(
              fontSize: 18,
            ),
      ),
    );
  }

  void _filterSearchResults(String query) {
    List<Currency> searchResult = <Currency>[];

    if (query.isEmpty) {
      searchResult.addAll(_currencyList);
    } else {
      searchResult = _currencyList
          .where(
            (c) =>
                c.name.toLowerCase().contains(query.toLowerCase().trim()) ||
                c.code.toLowerCase().contains(query.toLowerCase().trim()),
          )
          .toList();
    }

    setState(() => _filteredList = searchResult);
  }
}
