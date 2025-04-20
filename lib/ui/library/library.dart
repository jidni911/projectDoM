import 'package:flutter/material.dart';
import 'package:project_dom/models/book_requests.dart';
import 'package:project_dom/models/books.dart';
import 'package:project_dom/models/students.dart';
import 'package:project_dom/models/users.dart';
import 'package:project_dom/service/auth_service.dart';
import 'package:project_dom/ui/library/all_book_list_page.dart';
import 'package:project_dom/ui/library/claimed_books_list_page.dart';
import 'package:project_dom/ui/library/over_due_books_list_page.dart';
import 'package:project_dom/ui/library/requested_books_list_page.dart';
// import 'package:project_dom/ui/library/book_card.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final authService = AuthService();
  User? user;
  @override
  void initState() {
    super.initState();
    authService.getProfileLocal().then((value) => setState(() {
          user = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    // return const AllBookListPage();
    return Column(
      children: [
        if (user == null) const Text("Library") else Text(user?.fullName ?? ''),
        Expanded(child: MyBookListPage()),
      ],
    );
  }
}

class MyBookListPage extends StatelessWidget {
  const MyBookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(children: [
        TabBar(
          tabs: [
            Tab(text: "All Books"),
            Tab(text: "Requested"),
            Tab(text: "Taken"),
            Tab(text: "Over Due"),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              const AllBookListPage(),
              RequestedBooksListPage(),
              ClaimedBooksListPage(),
              OverDueBooksListPage(),
            ],
          ),
        ),
      ]),
    );
  }
}
