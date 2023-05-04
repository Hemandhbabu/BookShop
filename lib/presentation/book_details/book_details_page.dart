import 'package:book_shop/data/model/book.dart';
import 'package:book_shop/data/repository/books_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/cart_icon.dart';

//Listening for cart count for the selected book
final cartsCountProvider = Provider.family.autoDispose(
  (ref, Book book) {
    final books = ref.watch(repository.cartProvider);
    return books.where((element) => element == book).length;
  },
);

class BookDetailsPage extends StatelessWidget {
  static const route = 'book-details-page';
  final Book book;
  const BookDetailsPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [CartIcon()],
      ),
      body: ListView(
        children: [
          //Filling the image for 75% of width
          FractionallySizedBox(
            widthFactor: 0.75,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Image.network(book.coverImageUrl, fit: BoxFit.contain),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            book.title,
            style: const TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 30, 12, 0),
            child: Text(
              '\$ ${book.priceInDollar}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (book.categories.isNotEmpty)
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 24, 12, 0),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
          if (book.categories.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Wrap(
                spacing: 12,
                runSpacing: -6,
                children:
                    book.categories.map((e) => Chip(label: Text(e))).toList(),
              ),
            ),
          if (book.availableFormat.isNotEmpty)
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 24, 12, 0),
              child: Text(
                'Available formats',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
          if (book.availableFormat.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Consumer(builder: (context, ref, child) {
                return Wrap(
                  spacing: 12,
                  runSpacing: -6,
                  children: book.availableFormat
                      .map((e) => Chip(label: Text(e)))
                      .toList(),
                );
              }),
            ),
        ],
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final count = ref.watch(cartsCountProvider(book));
          return Container(
            height: 64,
            margin: const EdgeInsets.fromLTRB(12, 3, 12, 6),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(48)),
              color: Theme.of(context).colorScheme.primary,
            ),
            //If count = 0, "Add to cart" button will be shown
            //else number of selected books count and add, remove button will be shown
            child: count > 0
                ? Row(
                    children: [
                      Expanded(
                        child: IconButton(
                          onPressed: () => ref
                              .read(repository.cartProvider.notifier)
                              .remove(book),
                          icon: const Icon(
                            Icons.remove_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          '$count item${count == 1 ? '' : 's'} in cart',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () => ref
                              .read(repository.cartProvider.notifier)
                              .add(book),
                          icon: const Icon(
                            Icons.add_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : InkWell(
                    onTap: () =>
                        ref.read(repository.cartProvider.notifier).add(book),
                    child: const Center(
                      child: Text(
                        'Add to cart',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
