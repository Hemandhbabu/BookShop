import 'package:book_shop/data/model/book.dart';
import 'package:book_shop/presentation/book_details/book_details_page.dart';
import 'package:flutter/material.dart';

class BookTile extends StatelessWidget {
  final Book book;
  const BookTile({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: () => Navigator.pushNamed(
          context,
          BookDetailsPage.route,
          arguments: book,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: SizedBox.expand(
                child: Image.network(
                  book.coverImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: Colors.black54,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    book.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
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
