import 'package:flutter/material.dart';
import 'package:project_dom/models/book_requests.dart';
import 'package:project_dom/models/users.dart';
import 'package:project_dom/service/auth_service.dart';
import 'package:project_dom/service/book_service.dart';
import 'package:project_dom/ui/library/requested_books_card.dart';

class RequestedBooksListPage extends StatefulWidget {
  RequestedBooksListPage({super.key});

  @override
  State<RequestedBooksListPage> createState() => _RequestedBooksListPageState();
}

class _RequestedBooksListPageState extends State<RequestedBooksListPage> {
  AuthService authService = AuthService();
  BookService bookService = BookService();
  User? user;
  List<BookRequest> requestedBookRequests = [];

  @override
  initState() {
    super.initState();
    loadBookRequests();
  }

  loadBookRequests() async {
    authService.getProfileLocal().then((value) => {
          if (value != null)
            {
              bookService.getBookRequests().then((value) => setState(() {
                    requestedBookRequests = value;
                    print(requestedBookRequests);
                  }))
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) =>
            BookRequestCard(bookRequest: requestedBookRequests[index]),
        itemCount: requestedBookRequests.length);
  }
}
