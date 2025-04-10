import 'package:flutter/material.dart';
import 'package:project_dom/models/book_requests.dart';
import 'package:project_dom/ui/library/library.dart';

class OverDueBooksListPage extends StatelessWidget {
  const OverDueBooksListPage({required this.overDueBooks, super.key});

  final List<BookRequest> overDueBooks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) =>
            BookRequestCard(bookRequest: overDueBooks[index]),
        itemCount: overDueBooks.length);
  }
}