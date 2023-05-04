import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'book_shop_app.dart';
import 'data/repository/books_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeSharedPrefs();
  runApp(const ProviderScope(child: BookShopApp()));
}
