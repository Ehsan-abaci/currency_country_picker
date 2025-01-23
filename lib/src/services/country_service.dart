import '../constant/countries.dart';
import '../model/country.dart';

class CountryService {
  final List<Country> _countries;

  CountryService()
      : _countries = countries.map((country) => Country.fromJson(country)).toList();

  /// Return list with all countries
  List<Country> getAllCountries() => _countries;

  ///Return country by id
  Country? getCountryById(int id) =>
      _countries.where((country) => country.id == id).firstOrNull;

  /// Return country by phone code
  List<Country>? getCountryByCode(String phoneCode) =>
      _countries.where((country) => country.phoneCode == phoneCode).toList();

  /// Return country by name
  Country? getCountryByName(String name) =>
      _countries.where((country) => country.name == name).firstOrNull;

  /// Return list with all the countries that mach the given codes list.
  List<Country> getCountriesByPhoneCodes(List<String> codes) {
    final List<String> _codes = codes.map((code) => code.replaceFirst('+', '')).toList();
    final List<Country> countries = [];
    for (final code in _codes) {
      final List<Country>? country = getCountryByCode(code);
      if (country != null) {
        countries.addAll(country);
      }
    }
    return countries;
  }
}
