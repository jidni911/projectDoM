import 'package:flutter/material.dart';
import 'package:project_dom/models/books.dart';
import 'package:project_dom/service/book_service.dart';

class NewBookForm extends StatefulWidget {
  const NewBookForm({super.key, required this.loadBooks});

  @override
  State<NewBookForm> createState() => _NewBookFormState();

  final Function loadBooks;
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
  var bookService = BookService();
  int count = 0;

  @override
  Widget build(BuildContext context) {
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
    TextEditingController imageUrlController = TextEditingController();

    List<Book> dBooks = demoBooks;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: authorController,
              decoration: const InputDecoration(labelText: 'Author'),
            ),
            TextField(
              controller: isbnController,
              decoration: const InputDecoration(labelText: 'ISBN'),
            ),
            TextField(
              controller: publisherController,
              decoration: const InputDecoration(labelText: 'Publisher'),
            ),
            TextField(
              controller: publishedDateController,
              decoration: const InputDecoration(labelText: 'Published Date'),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: languageController,
              decoration: const InputDecoration(labelText: 'Language'),
            ),
            TextField(
              controller: totalCopiesController,
              decoration: const InputDecoration(labelText: 'Total Copies'),
            ),
            TextField(
              controller: availableCopiesController,
              decoration: const InputDecoration(labelText: 'Available Copies'),
            ),
            TextField(
              controller: shelfLocationController,
              decoration: const InputDecoration(labelText: 'Shelf Location'),
            ),
            TextField(
              controller: imageUrlController,
              decoration: const InputDecoration(labelText: 'Image Url'),
            ),
            ElevatedButton(
              onPressed: () {
                var book = Book(
                  title: titleController.text,
                  author: authorController.text,
                  isbn: isbnController.text,
                  publisher: publisherController.text,
                  publishedDate: DateTime.parse(publishedDateController.text),
                  category: categoryController.text,
                  language: languageController.text,
                  totalCopies: int.parse(totalCopiesController.text),
                  availableCopies: int.parse(availableCopiesController.text),
                  shelfLocation: shelfLocationController.text,
                  imageUrl: imageUrlController.text,
                );
                bookService
                    .createBook(book)
                    .then((value) => widget.loadBooks());
                Navigator.pop(context, book);
              },
              child: const Text('Submit'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                titleController.text = '';
                authorController.text = '';
                isbnController.text = '';
                publisherController.text = '';
                publishedDateController.text = '';
                categoryController.text = '';
                languageController.text = '';
                totalCopiesController.text = '';
                availableCopiesController.text = '';
                shelfLocationController.text = '';
                imageUrlController.text = '';
              },
              child: const Text('Reset'),
            ),
            ElevatedButton(
              onPressed: () {
                var book = dBooks[count++ % dBooks.length];
                titleController.text = book.title;
                authorController.text = book.author;
                isbnController.text = book.isbn;
                publisherController.text = book.publisher;
                publishedDateController.text = book.publishedDate.toString();
                categoryController.text = book.category;
                languageController.text = book.language;
                totalCopiesController.text = book.totalCopies.toString();
                availableCopiesController.text =
                    book.availableCopies.toString();
                shelfLocationController.text = book.shelfLocation;
                imageUrlController.text = book.imageUrl ?? '';
              },
              child: const Text('Demo'),
            ),
          ],
        ),
      ),
    );
  }
}
