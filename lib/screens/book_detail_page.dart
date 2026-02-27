import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../core/theme.dart';
import '../services/firebase_service.dart';

class BookDetailPage extends StatelessWidget {
  final String bookId;
  final String title;
  final String author;
  final String image;
  final bool available;

  const BookDetailPage({
    super.key,
    required this.bookId,
    required this.title,
    required this.author,
    required this.image,
    required this.available,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,

        child: Column(
          children: [
            // HERO IMAGE
            Hero(
              tag: bookId,

              child: Container(
                height: 300,
                width: double.infinity,

                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      author,
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 30),

                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),

                      width: double.infinity,

                      child: ElevatedButton(
                        onPressed: available
                            ? () {
                                FirebaseService().reserveBook(
                                  bookId,
                                  FirebaseAuth.instance.currentUser!.uid,
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Book Reserved"),
                                  ),
                                );
                              }
                            : null,

                        child: Text(
                          available ? "Reserve Book" : "Not Available",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
