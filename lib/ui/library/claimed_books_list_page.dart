import 'package:flutter/material.dart';
import 'package:project_dom/models/book_requests.dart';
import 'package:project_dom/ui/library/library.dart';
import 'package:project_dom/ui/library/requested_books_card.dart';

class ClaimedBooksListPage extends StatelessWidget {
  ClaimedBooksListPage({super.key});

  final List<BookRequest> claimedBookRequests = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) => BookRequestCard(
              bookRequest: claimedBookRequests[index],
            ),
        itemCount: claimedBookRequests.length);
  }
}
