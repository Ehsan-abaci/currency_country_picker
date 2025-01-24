import 'package:flutter/material.dart';

import '../currency_country_picker.dart';

class CountryListView extends StatefulWidget {
  /// The callback that is called when a country is selected
  final ValueChanged<Country> onSelect;

  /// The theme of the screen
  final CountryPickerThemeData? theme;

  /// The filtered countries
  final List<String>? countryFilter;

  /// The favorites countries
  final List<String>? favorites;

  final bool showFlag;

  final bool showPhone;

  final bool showSearchField;

  final bool showCountryName;

  const CountryListView({
    super.key,
    required this.onSelect,
    this.theme,
    this.countryFilter,
    this.favorites,
    required this.showFlag,
    required this.showPhone,
    required this.showSearchField,
    required this.showCountryName,
  }) : assert(countryFilter == null || favorites == null);

  @override
  State<CountryListView> createState() => _CountryListViewState();
}

class _CountryListViewState extends State<CountryListView> {
  /// The country service
  final CountryService _countryService = CountryService();

  /// The list of countries
  late List<Country> _countryList;

  /// The filtered list
  late List<Country> _filteredList;

  List<Country>? _favoriteList;

  /// The search controller
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    _filteredList = <Country>[];
    _countryList = _countryService.getAllCountries();

    if (widget.countryFilter != null) {
      final filteredCountries =
          _countryService.getCountriesByPhoneCodes(widget.countryFilter!);
      _countryList.removeWhere((country) => filteredCountries.contains(country));
    }

    if (widget.favorites != null) {
      _favoriteList = _countryService.getCountriesByPhoneCodes(widget.favorites!);
    }
    _filteredList.addAll(_countryList);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.showSearchField)
          _SearchField(
            searchController: _searchController,
            theme: widget.theme,
            onSearch: _filterSearchResults,
          ),
        Expanded(
          child: ListView(
            children: [
              if (_favoriteList != null) ...[
                ..._favoriteList!.map<Widget>((country) => _listRow(country)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(thickness: 1),
                ),
              ],
              ..._filteredList.map<Widget>((country) => _listRow(country)),
            ],
          ),
        ),
      ],
    );
  }

  void _filterSearchResults(String query) {
    List<Country> searchResult = <Country>[];

    if (query.isEmpty) {
      searchResult.addAll(_countryList);
    } else {
      searchResult = _countryList
          .where(
            (c) =>
                c.name.toLowerCase().contains(query.toLowerCase().trim()) ||
                "+${c.phoneCode}".toLowerCase().contains(query.toLowerCase().trim()),
          )
          .toList();
    }

    setState(() => _filteredList = searchResult);
  }

  _listRow(Country country) {
    final flagTextStyle = widget.theme?.flagSize != null
        ? TextStyle(fontSize: widget.theme?.flagSize)
        : const TextStyle(fontSize: 25);

    String? locale = Localizations.maybeLocaleOf(context)?.languageCode;
    return ListTile(
      minLeadingWidth: 30,
      contentPadding: const EdgeInsets.symmetric(horizontal: 25),
      title: widget.showCountryName
          ? Text(
              country.translations[locale] ?? country.name,
              style: widget.theme?.titleTextStyle ??
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            )
          : null,
      leading: widget.showFlag
          ? Text(
              country.emoji,
              style: flagTextStyle,
            )
          : null,
      trailing: widget.showPhone
          ? Text(
              "+${country.phoneCode}",
              style: widget.theme?.countryCodeTextStyle ??
                  const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
            )
          : null,
      onTap: () {
        widget.onSelect(country);
        Navigator.pop(context);
      },
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    super.key,
    required this.searchController,
    required this.onSearch,
    this.theme,
  });

  final TextEditingController searchController;
  final CountryPickerThemeData? theme;
  final ValueChanged<String> onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        decoration: theme?.inputDecoration ??
            InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
        onChanged: (q) {
          onSearch(q);
        },
      ),
    );
  }
}
