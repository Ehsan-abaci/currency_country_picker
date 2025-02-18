import 'package:currency_country_picker/src/model/country.dart';
import 'package:currency_country_picker/src/services/country_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'theme/country_picker_theme_data.dart';

class CountryScreen extends StatefulWidget {
  /// The callback that is called when a country is selected
  final ValueChanged<Country> onSelect;

  /// The theme of the screen
  final CountryPickerThemeData? theme;

  /// The filtered countries
  final List<String>? countryFilter;

  /// The favorites countries
  final List<String>? favorites;

  const CountryScreen({
    super.key,
    required this.onSelect,
    this.theme,
    this.countryFilter,
    this.favorites,
  }) : assert(countryFilter == null || favorites == null);

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  /// The country service
  final CountryService _countryService = CountryService();

  /// The list of countries
  late List<Country> _countryList;

  /// The filtered list
  late List<Country> _filteredList;

  List<Country>? _favoriteList;

  /// The search controller
  late TextEditingController _searchController;

  /// The notifier for the search mode
  final ValueNotifier<bool> isSearchingMode = ValueNotifier(false);

  @override
  void initState() {
    _searchController = TextEditingController();
    _filteredList = <Country>[];
    _countryList = _countryService.getAllCountries();

    if (widget.countryFilter != null) {
      final filteredCountries =
          _countryService.getCountriesByPhoneCodes(widget.countryFilter!);
      _countryList
          .removeWhere((country) => filteredCountries.contains(country));
    }

    if (widget.favorites != null) {
      _favoriteList =
          _countryService.getCountriesByPhoneCodes(widget.favorites!);
    }
    _filteredList.addAll(_countryList);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme?.backgroundColor ?? Colors.black,
      appBar: SearchAppBar(
        countryList: _filteredList,
        isSearchingMode: isSearchingMode,
        searchController: _searchController,
        theme: widget.theme,
        onSearch: _filterSearchResults,
      ),
      body: ListView(
        children: [
          if (_favoriteList != null) ...[
            ..._favoriteList!.map<Widget>((country) => _listRow(country)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(thickness: 1),
            ),
          ],
          ..._filteredList.map<Widget>((currency) => _listRow(currency)),
        ],
      ),
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
                "+${c.phoneCode}"
                    .toLowerCase()
                    .contains(query.toLowerCase().trim()),
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
      title: Text(
        country.translations[locale] ?? country.name,
        style: widget.theme?.titleTextStyle ??
            const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
      ),
      leading: Text(
        country.emoji,
        style: flagTextStyle,
      ),
      trailing: Text(
        "+${country.phoneCode}",
        style: widget.theme?.countryCodeTextStyle ??
            const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
      ),
      onTap: () {
        widget.onSelect(country);
        Navigator.pop(context);
      },
    );
  }
}

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  SearchAppBar({
    super.key,
    required this.onSearch,
    required this.countryList,
    required this.isSearchingMode,
    required this.searchController,
    this.theme,
  });
  final List<Country> countryList;
  final ValueChanged<String> onSearch;
  final ValueNotifier<bool> isSearchingMode;
  final CountryPickerThemeData? theme;

  final TextEditingController searchController;
  final FocusNode _focusNode = FocusNode();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isSearchingMode,
      builder: (ctx, isSearching, _) {
        // When searching mode is active, request focus
        if (isSearching && !_focusNode.hasFocus) {
          // Request focus after the widget is built
          WidgetsBinding.instance.addPostFrameCallback((_) {
            FocusScope.of(context).requestFocus(_focusNode);
          });
        }
        return AppBar(
          title: isSearching
              ? TextField(
                  controller: searchController,
                  focusNode: _focusNode,
                  style: theme?.searchTextStyle ??
                      const TextStyle(
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
                )
              : const Text('Choose a country'),
          backgroundColor: theme?.backgroundColor ?? Colors.black,
          actions: [
            IconButton(
              onPressed: () {
                isSearchingMode.value = !isSearchingMode.value;
              },
              icon: isSearching
                  ? const Icon(Icons.close_rounded)
                  : const Icon(CupertinoIcons.search),
            )
          ],
        );
      },
    );
  }
}
