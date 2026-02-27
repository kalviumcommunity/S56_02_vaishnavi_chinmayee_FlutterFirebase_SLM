import 'package:flutter/material.dart';
import '../models/book_model.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onReserve;

  const BookCard({super.key, required this.book, required this.onReserve});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),

      child: Padding(
        padding: const EdgeInsets.all(10),

        child: Row(
          children: [
            Image.network(book.image, width: 60, height: 90, fit: BoxFit.cover),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(book.author),

                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: book.available ? onReserve : null,
                    child: Text(book.available ? "Reserve" : "Not Available"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
