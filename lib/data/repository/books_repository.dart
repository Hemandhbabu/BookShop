import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/book.dart';

//Global variables for gloabl access
SharedPreferences? _preferences;
final repository = BooksRepository();

//Function to initialize shared preferences on app launch
Future<void> initializeSharedPrefs() async {
  _preferences ??= await SharedPreferences.getInstance();
}

class BooksRepository {
  Future<List<Map<String, dynamic>>> _getAllBooksData() async {
    //Loading data from local file
    final response = await rootBundle.loadString('asset/all_books.json');
    return (json.decode(response) as List).cast<Map<String, dynamic>>();
  }

  Future<List<Book>> getAllBooks() async {
    final data = await _getAllBooksData();
    return data.map((e) => Book.fromMap(e)).toList();
  }

  final cartProvider = StateNotifierProvider<CartProvider, List<Book>>((ref) {
    //Gets the shared preferences and provide cart books
    final response = _preferences!.getString('cart');
    final bookData = response == null
        ? []
        : (json.decode(response) as List).cast<Map<String, dynamic>>();
    final books = bookData.isEmpty
        ? <Book>[]
        : bookData.map((e) => Book.fromMap(e)).toList();
    return CartProvider(books);
  });
}

class CartProvider extends StateNotifier<List<Book>> {
  CartProvider(super._state);

  void add(Book book) {
    final local = [...state];
    local.add(book);
    state = local;
    final data = local.map((e) => e.toMap()).toList();
    _preferences!.setString('cart', json.encode(data));
  }

  void remove(Book book) {
    final local = [...state];
    if (local.isEmpty) return;
    local.remove(book);
    state = local;
    final data = local.map((e) => e.toMap()).toList();
    _preferences!.setString('cart', json.encode(data));
  }

  void clearCart() {
    state = [];
    _preferences!.remove('cart');
  }
}
