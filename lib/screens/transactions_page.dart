import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionsPage extends StatelessWidget {
  final finePerDay = 10;

  Future returnBook(
    String transactionId,
    DateTime dueDate,
    String bookId,
  ) async {
    var returnDate = DateTime.now();

    int fine = 0;

    if (returnDate.isAfter(dueDate)) {
      fine = returnDate.difference(dueDate).inDays * finePerDay;
    }

    await FirebaseFirestore.instance
        .collection("transactions")
        .doc(transactionId)
        .update({"returnDate": returnDate, "fine": fine, "status": "returned"});

    await FirebaseFirestore.instance.collection("books").doc(bookId).update({
      "available": true,
      "reservedBy": "",
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transactions")),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("transactions")
            .snapshots(),

        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          var data = snapshot.data!.docs;

          return ListView.builder(
            itemCount: data.length,

            itemBuilder: (context, index) {
              var doc = data[index];

              return ListTile(
                title: Text(doc["bookId"]),

                subtitle: Text("Fine: ₹${doc["fine"]}"),

                trailing: ElevatedButton(
                  onPressed: doc["status"] == "issued"
                      ? () {
                          returnBook(
                            doc.id,
                            doc["dueDate"].toDate(),
                            doc["bookId"],
                          );
                        }
                      : null,

                  child: Text("Return"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
