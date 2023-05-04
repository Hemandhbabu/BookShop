import 'package:flutter/foundation.dart';

//Model for book
class Book {
  final String title;
  final String coverImageUrl;
  final double priceInDollar;
  final List<String> categories;
  final List<String> availableFormat;

  const Book({
    required this.title,
    required this.coverImageUrl,
    required this.priceInDollar,
    required this.categories,
    required this.availableFormat,
  });

  Book copyWith({
    String? title,
    String? coverImageUrl,
    double? priceInDollar,
    List<String>? categories,
    List<String>? availableFormat,
  }) {
    return Book(
      title: title ?? this.title,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      priceInDollar: priceInDollar ?? this.priceInDollar,
      categories: categories ?? this.categories,
      availableFormat: availableFormat ?? this.availableFormat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'cover_image_url': coverImageUrl,
      'price_in_dollar': priceInDollar,
      'categories': categories,
      'available_format': availableFormat,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      title: map['title'] as String,
      coverImageUrl: map['cover_image_url'] as String,
      priceInDollar: (map['price_in_dollar'] as num).toDouble(),
      categories: (map['categories'] as List?)?.cast<String>() ?? [],
      availableFormat: (map['available_format'] as List?)?.cast<String>() ?? [],
    );
  }

  @override
  String toString() {
    return '''Book(
      title: $title, 
      coverImageUrl: $coverImageUrl, 
      priceInDollar: $priceInDollar, 
      categories: $categories, 
      availableFormat: $availableFormat
      )''';
  }

  @override
  bool operator ==(covariant Book other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.coverImageUrl == coverImageUrl &&
        other.priceInDollar == priceInDollar &&
        listEquals(other.categories, categories) &&
        listEquals(other.availableFormat, availableFormat);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        coverImageUrl.hashCode ^
        priceInDollar.hashCode ^
        categories.hashCode ^
        availableFormat.hashCode;
  }
}
