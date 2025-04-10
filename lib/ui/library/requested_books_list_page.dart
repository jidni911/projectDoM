import 'package:flutter/material.dart';
import 'package:project_dom/models/book_requests.dart';
import 'package:project_dom/ui/library/library.dart';

class RequestedBooksListPage extends StatelessWidget {
  const RequestedBooksListPage({required this.issuedBookRequests, super.key});

  final List<BookRequest> issuedBookRequests;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) =>
            BookRequestCard(bookRequest: issuedBookRequests[index]),
        itemCount: issuedBookRequests.length);
  }
}