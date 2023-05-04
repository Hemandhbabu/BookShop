import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/books_repository.dart';
import '../cart/cart_page.dart';

class CartIcon extends ConsumerWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () => Navigator.pushNamed(context, CartPage.route),
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          const Icon(Icons.shopping_bag_rounded),
          //Showing cart item count on top right corner
          Positioned(
            right: -4,
            top: -4,
            child: Container(
              height: 16,
              width: 16,
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
              ),
              child: FittedBox(
                child: Text(
                  ref.watch(
                    repository.cartProvider
                        .select((value) => '${value.length}'),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).appBarTheme.foregroundColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
