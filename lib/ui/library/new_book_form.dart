import 'package:flutter/material.dart';

class NewBookForm extends StatefulWidget {
  const NewBookForm({super.key});

  @override
  State<NewBookForm> createState() => _NewBookFormState();
}

// String title;
//   String author;
//   String isbn;
//   String publisher;
//   DateTime publishedDate;
//   String category;
//   String language;
//   int totalCopies;
//   int availableCopies;
//   String shelfLocation;
//   DateTime createdAt;
//   DateTime updatedAt;
//   String? imageUrl;
class _NewBookFormState extends State<NewBookForm> {
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController isbnController = TextEditingController();
  TextEditingController publisherController = TextEditingController();
  TextEditingController publishedDateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController totalCopiesController = TextEditingController();
  TextEditingController availableCopiesController = TextEditingController();
  TextEditingController shelfLocationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: []),
    );
  }
}
