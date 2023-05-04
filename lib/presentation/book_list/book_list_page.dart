import 'package:book_shop/presentation/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/books_repository.dart';
import '../core/cart_icon.dart';
import 'book_tile.dart';

//Getting all  books and persisting throughout the app launch
final booksProvider = FutureProvider((ref) => repository.getAllBooks());

class BookListPage extends ConsumerWidget {
  static const route = 'book-list-page';
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
        actions: [
          IconButton(
            //Navigating to search page
            onPressed: () => Navigator.pushNamed(context, SearchPage.route),
            icon: const Icon(Icons.search_rounded),
          ),
          const CartIcon(),
        ],
      ),
      //Listening to books provider and return widget based on the state
      body: ref.watch(booksProvider).when(
            error: (error, stack) {
              return Center(
                child: Text(error.toString()),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            data: (books) {
              if (books.isEmpty) {
                return const Center(child: Text('No books'));
              }
              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                itemCount: books.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (context, index) => BookTile(book: books[index]),
              );
            },
          ),
    );
  }
}
