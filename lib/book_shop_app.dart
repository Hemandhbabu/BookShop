import 'package:book_shop/data/model/book.dart';
import 'package:book_shop/presentation/book_details/book_details_page.dart';
import 'package:book_shop/presentation/search/search_page.dart';
import 'package:flutter/material.dart';

import 'presentation/book_list/book_list_page.dart';
import 'presentation/cart/cart_page.dart';
import 'presentation/core/theme.dart';

class BookShopApp extends StatelessWidget {
  const BookShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Shop',
      theme: theme,
      routes: {
        BookListPage.route: (context) => const BookListPage(),
        BookDetailsPage.route: (context) {
          final book = ModalRoute.of(context)!.settings.arguments as Book;
          return BookDetailsPage(book: book);
        },
        CartPage.route: (context) => const CartPage(),
        SearchPage.route: (context) => const SearchPage(),
      },
      initialRoute: BookListPage.route,
    );
  }
}
