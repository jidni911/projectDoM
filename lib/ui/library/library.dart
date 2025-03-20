import 'package:flutter/material.dart';
import 'package:project_dom/models/book_requests.dart';
import 'package:project_dom/models/books.dart';
import 'package:project_dom/models/demo_book_requests.dart';
import 'package:project_dom/models/students.dart';
import 'package:project_dom/ui/library/all_book_list_page.dart';
import 'package:project_dom/ui/library/book_card.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AllBookListPage();
    // return const MyBookListPage();
  }
}

class MyBookListPage extends StatelessWidget {
  const MyBookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<BookRequest> bookRequests = demoBookRequests;
    List<BookRequest> issuedBookRequests = [];
    List<BookRequest> claimedBookRequests = [];
    for (var book in bookRequests) {
      if (book.status == RequestStatus.issued) {
        issuedBookRequests.add(book);
      } else if (book.status == RequestStatus.claimed) {
        claimedBookRequests.add(book);
      }
    }
    return DefaultTabController(
      length: 3,
      child: Column(children: [
        TabBar(
          tabs: [
            Tab(text: "Requested"),
            Tab(text: "Taken"),
            Tab(text: "Over Due"),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              ListView.builder(
                  itemBuilder: (context, index) =>
                      BookRequestCard(bookRequest: issuedBookRequests[index]),
                  itemCount: issuedBookRequests.length),
              ListView.builder(
                  itemBuilder: (context, index) =>
                      BookRequestCard(bookRequest: claimedBookRequests[index]),
                  itemCount: claimedBookRequests.length),
              ListView.builder(
                  itemBuilder: (context, index) =>
                      BookRequestCard(bookRequest: claimedBookRequests[index]),
                  itemCount: claimedBookRequests.length),
            ],
          ),
        ),
      ]),
    );
  }
}

class BookRequestCard extends StatelessWidget {
  const BookRequestCard({required this.bookRequest, super.key});
  final BookRequest bookRequest;

  @override
  Widget build(BuildContext context) {
    Book book = demoBooks[bookRequest.bookId - 1];
    Student student = demoStudents[bookRequest.userId - 1];
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 400) {
          return Text(
              'Cant show book card\n with width ${constraints.maxWidth.ceil()}, \n contact developer');
        } else {
          return ListTile(
            leading: book.imageUrl != null
                ? Image(
                    image: NetworkImage(book.imageUrl!), height: 50, width: 50)
                : Icon(Icons.book, size: 50),
            title: Row(mainAxisSize: MainAxisSize.min, children: [
              Text(book.title),
              if (constraints.maxWidth >= 580)
                Text(' - (${book.language})',
                    style: TextStyle(color: Colors.grey)),
            ]),
            subtitle: Row(mainAxisSize: MainAxisSize.min, children: [
              Text(book.author),
              if (constraints.maxWidth >= 580)
                Text(' - (${book.publishedDate.year})',
                    style: TextStyle(color: Colors.grey)),
            ]),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              student.imageUrl != null
                  ? Image(
                      image: NetworkImage(student.imageUrl!),
                      height: 50,
                      width: 50)
                  : Icon(Icons.person, size: 50),
              Column(children: [
                Text(
                  '${student.name} ( ${student.getYear()} )',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  'Roll: ${student.classRoll} Phone:  ${student.phone}',
                  style: TextStyle(color: Colors.grey),
                ),
              ]),
              if (constraints.maxWidth >= 850)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Borrow'),
                  ),
                ),
              if (constraints.maxWidth >= 850)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Details'),
                  ),
                ),
              if (constraints.maxWidth < 850)
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ), // Three-dot icon
                  onSelected: (value) {
                    print("Selected: $value");
                  },
                  itemBuilder: (context) => [
                    if (constraints.maxWidth < 490)
                      PopupMenuItem(
                        enabled: false,
                        child: Text(
                            "available ${book.availableCopies} / ${book.totalCopies}"),
                      ),
                    PopupMenuItem(value: "edit", child: Text("Borrow")),
                    PopupMenuItem(value: "delete", child: Text("Details")),
                  ],
                )
            ]),
          );
        }
      },
    );
  }
}
