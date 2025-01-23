# Country & Currency picker

[![pub package](https://img.shields.io/pub/v/currency_country_picker.svg)](https://pub.dev/packages/currency_country_picker)

A flutter package to select a currency and country from a list with **250 countries**.

<p align="center">
  <img src="https://raw.githubusercontent.com/Ehsan-Abaci/currency_country_picker/master/assets/country-screen.png" width="250"/>
  <img src="https://raw.githubusercontent.com/Ehsan-Abaci/currency_country_picker/master/assets/currency-bottomsheet.png" width="250"/>
</p>

## Getting Started

Add the package to your pubspec.yaml:

 ```yaml
 currency_country_picker: ^1.1.1
 ```

In your dart file, import the library:

 ```Dart
 import 'package:currency_country_picker/currency_country_picker.dart';
 ``` 
Show country picker using `showCountryPickerFullScreen`:
```Dart
showCountryPickerFullScreen(
   context: context,
   showFlag: true,
   onSelect: (Country country) {
      print('Select country: ${country.phoneCode}');
   },
);
```

### Parameters:
* `onSelect`: Called when a country is select. The country picker passes the new value to the callback (required)
* `showFlag`: Shows flag for each country. Default value `true`.
* `countryFilter`: Can be used to filter the Country list.
* `favorites`: Show the favorite countries at the top of the list.
  ```Dart
   showCountryPickerFullScreen(
      context: context,
      onSelect: (Country country) {
         print('Select country: ${country.phoneCode}');
      },
      countryFilter: <String>['+93', '+358','+355'],
   );
  ``` 
* `theme`: Set a `CountryPickerThemeData` to the country picker to customize it. (optional).
  ```Dart
   showCountryPickerFullScreen(
        context: context,
        theme: CountryPickerThemeData(
        countryCodeTextStyle: const TextStyle(
            color: Color.fromARGB(255, 168, 36, 60),
            fontSize: 17,
        ),
        titleTextStyle: const TextStyle(
            fontSize: 18,
            color:Colors.white,
        ),
        flagSize: 25,
        backgroundColor: Colors.black,
    ),
     onSelect: (Country country) => print('Select country: ${country.phoneCode}'),
   );
  ``` 
## Contributions
Contributions of any kind are more than welcome! Feel free to fork and improve currency_country_picker in any way you want, make a pull request, or open an issue.
