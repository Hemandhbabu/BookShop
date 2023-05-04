import 'package:book_shop/data/repository/books_repository.dart';
import 'package:book_shop/presentation/cart/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/book.dart';

class CartPage extends ConsumerWidget {
  static const route = 'cart-page';
  const CartPage({super.key});

  //Converting the number of books to books with count
  List<MapEntry<int, Book>> convertCart(List<Book> books) {
    final list = <Book>[];
    for (var item in books) {
      if (!list.contains(item)) list.add(item);
    }
    final filtered = <MapEntry<int, Book>>[];
    for (var item in list) {
      final count = books.where((element) => element == item).length;
      filtered.add(MapEntry(count, item));
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context, ref) {
    final items = ref.watch(repository.cartProvider);
    final filtered = convertCart(items);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                '( ${items.length} )',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          )
        ],
      ),
      body: items.isEmpty
          ? const Center(child: Text('No books in cart'))
          : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) => CartItem(item: filtered[index]),
            ),
      bottomNavigationBar: Card(
        margin: EdgeInsets.zero,
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (items.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                child: Text(
                  //Adding all book price and fixing 2 decimal points
                  'Total : \$${items.map((e) => e.priceInDollar).reduce((v, e) => v + e).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 21),
                ),
              ),
            Container(
              height: 64,
              margin: const EdgeInsets.fromLTRB(12, 3, 12, 6),
              child: ElevatedButton(
                //If no books or more than 5 books in cart, checkout button will be disabled
                onPressed: items.length > 5 || items.isEmpty
                    ? null
                    : () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: const Text('Order confirmed'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  //Clearing cart
                                  ref
                                      .watch(repository.cartProvider.notifier)
                                      .clearCart();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        ),
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                  ),
                ),
                child: Center(
                  child: Text(
                    items.length > 5
                        ? 'Max. 5 items can be checked out'
                        : 'Proceed to checkout',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
