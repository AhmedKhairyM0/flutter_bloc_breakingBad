class Quote {
  String quote;
  Quote({
    required this.quote,
  });

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      quote: map['quote'],
    );
  }

  @override
  String toString() => 'Quote(quote: $quote)';
}
