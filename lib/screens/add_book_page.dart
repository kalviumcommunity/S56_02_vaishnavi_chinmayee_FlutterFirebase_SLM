import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddBookPage extends StatefulWidget {
  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final imageController = TextEditingController();

  Future addBook() async {
    await FirebaseFirestore.instance.collection("books").add({
      "title": titleController.text,
      "author": authorController.text,
      "image": imageController.text,
      "available": true,
      "reservedBy": "",
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Book Added")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Book")),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),

            TextField(
              controller: authorController,
              decoration: InputDecoration(labelText: "Author"),
            ),

            TextField(
              controller: imageController,
              decoration: InputDecoration(labelText: "Image URL"),
            ),

            SizedBox(height: 20),

            ElevatedButton(onPressed: addBook, child: Text("Add Book")),
          ],
        ),
      ),
    );
  }
}
