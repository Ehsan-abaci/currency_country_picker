import 'dart:convert';

class Country {
  final int id;
  final String name;
  final String numericCode;
  final String phoneCode;
  final String capital;
  final String currencyCode;
  final String currencyName;
  final String currencySymbol; // Emoji or Symbol
  final String native;
  final String region;
  final int regionId;
  final String subregion;
  final int subregionId;
  final String nationality;
  final Map<String, String> translations;
  final String emoji; // Flag emoji
  final String emojiU; // Unicode representation

  Country({
    required this.id,
    required this.name,
    required this.numericCode,
    required this.phoneCode,
    required this.capital,
    required this.currencyCode,
    required this.currencyName,
    required this.currencySymbol,
    required this.native,
    required this.region,
    required this.regionId,
    required this.subregion,
    required this.subregionId,
    required this.nationality,
    required this.translations,
    required this.emoji,
    required this.emojiU,
  });

  // Factory method to create Country object from JSON
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      numericCode: json['numeric_code'] ?? '',
      phoneCode: json['phoneCode'] ?? '',
      capital: json['capital'] ?? '',
      currencyCode: json['currency_code'] ?? '',
      currencyName: json['currency_name'] ?? '',
      currencySymbol: json['currency_symbol'] ?? '',
      native: json['native'] ?? '',
      region: json['region'] ?? '',
      regionId: json['region_id'] ?? 0,
      subregion: json['subregion'] ?? '',
      subregionId: json['subregion_id'] ?? 0,
      nationality: json['nationality'] ?? '',
      translations: json['translations'] != null
          ? Map<String, String>.from(jsonDecode(json['translations']))
          : {},
      emoji: json['emoji'] ?? '',
      emojiU: json['emojiU'] != null ? _unicodeToEmoji(json['emojiU']) : '',
    );
  }

  // Helper function to convert Unicode points to actual emoji (e.g., "U+1F1EE U+1F1F7" to 🇮🇷)
  static String _unicodeToEmoji(String unicode) {
    final parts = unicode.split(' ');

    // Ensure there are exactly two parts (for flags, we need two code points)
    if (parts.length == 2) {
      int firstCodePoint = int.parse(parts[0].substring(2), radix: 16);
      int secondCodePoint = int.parse(parts[1].substring(2), radix: 16);
      return String.fromCharCode(firstCodePoint) + String.fromCharCode(secondCodePoint);
    }

    return unicode; // Return the original string if not in expected format
  }
}
