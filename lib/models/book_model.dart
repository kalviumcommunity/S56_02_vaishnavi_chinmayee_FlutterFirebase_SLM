class Book {
  String id;
  String title;
  String author;
  String image;
  bool available;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.image,
    required this.available,
  });

  factory Book.fromFirestore(Map<String, dynamic> data, String id) {
    return Book(
      id: id,
      title: data['title'],
      author: data['author'],
      image: data['image'],
      available: data['available'],
    );
  }
}
