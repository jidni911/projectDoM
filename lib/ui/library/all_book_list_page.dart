import 'package:flutter/material.dart';
import 'package:project_dom/models/books.dart';
import 'package:project_dom/ui/library/book_card.dart';

class AllBookListPage extends StatelessWidget {
  const AllBookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Book> books = demoBooks;

    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) => BookCard(book: books[index]),
    );
  }
}
