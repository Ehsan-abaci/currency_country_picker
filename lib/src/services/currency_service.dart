import 'package:currency_country_picker/src/model/currency.dart';

import '../constant/countries.dart';

class CurrencyService {
  final List<Currency> _currencies;

  CurrencyService()
      : _currencies = countries.map((currency) => Currency.fromJson(currency)).toList();

  /// Return list with all currencies
  List<Currency> getAllCurrencies() => _currencies;

  ///Returns the first currency that mach the given code.
  Currency? findByCode(String? code) {
    final uppercaseCode = code?.toUpperCase();
    return _currencies.where((currency) => currency.code == uppercaseCode).firstOrNull;
  }

  ///Returns the first currency that mach the given name.
  Currency? findByName(String? name) {
    return _currencies.where((currency) => currency.name == name).firstOrNull;
  }

  ///Returns a list with all the currencies that mach the given codes list.
  List<Currency> findCurrenciesByCode(List<String> codes) {
    final List<String> _codes = codes.map((code) => code.toUpperCase()).toList();
    final List<Currency> currencies = [];
    for (final code in _codes) {
      final Currency? currency = findByCode(code);
      if (currency != null) {
        currencies.add(currency);
      }
    }
    return currencies;
  }
}
