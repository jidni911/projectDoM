import 'package:flutter/material.dart';
import 'package:project_dom/models/books.dart';
import 'package:project_dom/service/book_service.dart';
import 'package:project_dom/ui/library/book_card.dart';
import 'package:project_dom/ui/library/new_book_form.dart';

class AllBookListPage extends StatefulWidget {
  const AllBookListPage({super.key});

  @override
  State<AllBookListPage> createState() => _AllBookListPageState();
}

class _AllBookListPageState extends State<AllBookListPage> {
  BookService bookService = BookService();
  List<Book> books = demoBooks;

  @override
  void initState() {
    super.initState();
    bookService.getBooks().then((value) => setState(() => books = value));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'All Books',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.search),
                label: Text('Search'),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.filter_alt),
                label: Text('Filter'),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.sort),
                label: Text('Sort'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.85,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return NewBookForm();
                      });
                },
                icon: Icon(Icons.add),
                label: Text('Add'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) => BookCard(book: books[index]),
          ),
        )
      ],
    );
  }
}
