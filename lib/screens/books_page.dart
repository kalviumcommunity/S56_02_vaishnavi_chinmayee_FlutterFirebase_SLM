import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/theme.dart';
import 'book_detail_page.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            "Books Library",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("books")
                  .snapshots(),

              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                var books = snapshot.data!.docs;

                if (books.isEmpty) {
                  return const Center(child: Text("No books found"));
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,

                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,

                    childAspectRatio: 0.65,
                  ),

                  itemCount: books.length,

                  itemBuilder: (context, index) {
                    var book = books[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,

                          PageRouteBuilder(
                            transitionDuration: const Duration(
                              milliseconds: 400,
                            ),

                            pageBuilder: (_, __, ___) => BookDetailPage(
                              bookId: book.id,
                              title: book["title"],
                              author: book["author"],
                              image: book["image"],
                              available: book["available"],
                            ),
                          ),
                        );
                      },

                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),

                        decoration: BoxDecoration(
                          color: AppColors.card,

                          borderRadius: BorderRadius.circular(16),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),

                        child: Column(
                          children: [
                            Expanded(
                              child: Hero(
                                tag: book.id,

                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),

                                  child: Image.network(
                                    book["image"],

                                    width: double.infinity,

                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(12),

                              child: Column(
                                children: [
                                  Text(
                                    book["title"],

                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),

                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    book["author"],

                                    style: const TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 13,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),

                                    decoration: BoxDecoration(
                                      color: book["available"]
                                          ? Colors.green.withOpacity(0.1)
                                          : Colors.red.withOpacity(0.1),

                                      borderRadius: BorderRadius.circular(8),
                                    ),

                                    child: Text(
                                      book["available"]
                                          ? "Available"
                                          : "Reserved",

                                      style: TextStyle(
                                        color: book["available"]
                                            ? Colors.green
                                            : Colors.red,

                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
