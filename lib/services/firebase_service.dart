import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // -------------------------
  // GET ALL BOOKS
  // -------------------------
  Stream<QuerySnapshot> getBooks() {
    return _db.collection("books").snapshots();
  }

  // -------------------------
  // ADD NEW BOOK (Admin)
  // -------------------------
  Future addBook({
    required String title,
    required String author,
    required String image,
  }) async {
    await _db.collection("books").add({
      "title": title,
      "author": author,
      "image": image,

      "available": true,
      "reservedBy": "",
      "dueDate": null,
    });
  }

  // -------------------------
  // ISSUE / RESERVE BOOK
  // -------------------------
  Future reserveBook(String bookId, String userId) async {
    // Due date = 7 days from now
    DateTime dueDate = DateTime.now().add(const Duration(days: 7));

    // Update book status
    await _db.collection("books").doc(bookId).update({
      "available": false,
      "reservedBy": userId,
      "dueDate": dueDate,
    });

    // Create transaction record
    await _db.collection("transactions").add({
      "bookId": bookId,
      "userId": userId,

      "issueDate": DateTime.now(),
      "dueDate": dueDate,

      "returnDate": null,
      "fine": 0,

      "status": "issued",
    });
  }

  // -------------------------
  // RETURN BOOK
  // -------------------------
  Future returnBook({
    required String transactionId,
    required String bookId,
    required DateTime dueDate,
  }) async {
    DateTime returnDate = DateTime.now();

    int fine = calculateFine(dueDate, returnDate);

    // Update transaction
    await _db.collection("transactions").doc(transactionId).update({
      "returnDate": returnDate,
      "fine": fine,
      "status": "returned",
    });

    // Make book available again
    await _db.collection("books").doc(bookId).update({
      "available": true,
      "reservedBy": "",
      "dueDate": null,
    });
  }

  // -------------------------
  // FINE CALCULATION
  // -------------------------
  int calculateFine(DateTime dueDate, DateTime returnDate) {
    const int finePerDay = 10;

    if (returnDate.isAfter(dueDate)) {
      int lateDays = returnDate.difference(dueDate).inDays;

      return lateDays * finePerDay;
    }

    return 0;
  }

  // -------------------------
  // GET USER TRANSACTIONS
  // -------------------------
  Stream<QuerySnapshot> getUserTransactions(String userId) {
    return _db
        .collection("transactions")
        .where("userId", isEqualTo: userId)
        .snapshots();
  }

  // -------------------------
  // GET ALL TRANSACTIONS (Admin)
  // -------------------------
  Stream<QuerySnapshot> getAllTransactions() {
    return _db.collection("transactions").snapshots();
  }
}
