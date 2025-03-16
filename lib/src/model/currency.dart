class Currency {
  final String code;
  final String name;
  final String symbol; // Symbol
  final String flag; // Flag emoji

  Currency({
    required this.code,
    required this.name,
    required this.symbol,
    required this.flag,
  });

  // Factory method to create Country object from JSON
  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      symbol: json['symbol'] ?? '',
      flag: json['flag'] != null ? currencyToEmoji(json['flag']) : '',
    );
  }

  static String currencyToEmoji(String flag) {
    // 0x41 is Letter A
    // 0x1F1E6 is Regional Indicator Symbol Letter A
    // Example :
    // firstLetter U => 20 + 0x1F1E6
    // secondLetter S => 18 + 0x1F1E6
    // See: https://en.wikipedia.org/wiki/Regional_Indicator_Symbol
    final int firstLetter = flag.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = flag.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }
}
