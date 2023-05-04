import 'package:book_shop/data/model/book.dart';
import 'package:book_shop/data/repository/books_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItem extends StatelessWidget {
  final MapEntry<int, Book> item;
  const CartItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final count = item.key;
    final book = item.value;
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 0.85,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Image.network(
                    book.coverImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    book.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${book.priceInDollar}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: [
                      Text('Qty : $count'),
                      const Spacer(),
                      Consumer(
                        builder: (context, ref, child) => IconButton(
                          iconSize: 18,
                          onPressed: () => ref
                              .watch(repository.cartProvider.notifier)
                              .remove(book),
                          icon: const Icon(Icons.delete_rounded),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
