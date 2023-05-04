import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/book.dart';
import '../../data/repository/books_repository.dart';
import '../book_list/book_tile.dart';

final queryProvider = StateProvider.autoDispose((ref) => '');
final queryBooksProvider = FutureProvider.autoDispose(
  (ref) async {
    //Seraching query with the book title
    final query = ref.watch(queryProvider);
    if (query.isEmpty) return <Book>[];
    final allBooks = await repository.getAllBooks();
    return allBooks.where((element) {
      return element.title.toLowerCase().contains(query);
    }).toList();
  },
);

class SearchPage extends ConsumerWidget {
  static const route = 'search-page';
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(queryProvider);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) =>
              ref.watch(queryProvider.notifier).update((state) => value),
          decoration: const InputDecoration.collapsed(hintText: 'Search'),
        ),
      ),
      body: ref.watch(queryBooksProvider).when(
            error: (error, stack) {
              return Center(
                child: Text(error.toString()),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            data: (books) {
              if (query.isEmpty) {
                return const Center(child: Text('Search books'));
              }
              if (books.isEmpty) {
                return Center(child: Text('No books for "$query"'));
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
