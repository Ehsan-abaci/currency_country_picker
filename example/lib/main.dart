import 'package:currency_country_picker/currency_country_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String countryTitle = 'Country';
  String currencyTitle = 'Currency';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Currency & Country Picker'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Country Picker full screen:'),
              ElevatedButton(
                onPressed: () => showCountryPickerFullScreen(
                  context: context,
                  theme: CountryPickerThemeData(
                    countryCodeTextStyle: const TextStyle(
                      color: Color.fromARGB(255, 168, 36, 60),
                      fontSize: 17,
                    ),
                  ),
                  favorites: ['98'],
                  onSelect: (country) {
                    setState(() {
                      countryTitle = country.name;
                    });
                  },
                ),
                child: Text(countryTitle),
              ),
              const Text('Country Picker dialog:'),
              ElevatedButton(
                onPressed: () => showCountryPickerDialog(
                  context: context,
                  theme: CountryPickerThemeData(
                    countryCodeTextStyle: const TextStyle(
                      color: Color.fromARGB(255, 168, 36, 60),
                      fontSize: 17,
                    ),
                  ),
                  showPhoneCode: true,
                  favorites: ['98'],
                  onSelect: (country) {
                    setState(() {
                      countryTitle = country.name;
                    });
                  },
                ),
                child: Text(countryTitle),
              ),
              const SizedBox(height: 50),
              const Text('Currency Picker:'),
              ElevatedButton(
                onPressed: () => showCurrencyPickerBottomSheet(
                  context: context,
                  favorites: ['IRR'],
                  onSelect: (currency) {
                    setState(() {
                      currencyTitle = currency.name;
                    });
                  },
                ),
                child: Text(currencyTitle),
              ),
            ],
          ),
        ));
  }
}
