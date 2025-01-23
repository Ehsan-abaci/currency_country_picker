class Currency {
  final int id;
  final String code;
  final String name;
  final String symbol; // Emoji or Symbol
  final String nationality;
  final String emoji; // Flag emoji
  final String emojiU; // Unicode representation

  Currency({
    required this.id,
    required this.code,
    required this.name,
    required this.symbol,
    required this.nationality,
    required this.emoji,
    required this.emojiU,
  });

  // Factory method to create Country object from JSON
  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'],
      code: json['currency_code'] ?? '',
      name: json['currency_name'] ?? '',
      symbol: json['currency_symbol'] ?? '',
      nationality: json['nationality'] ?? '',
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
