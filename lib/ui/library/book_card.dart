import 'package:flutter/material.dart';
import 'package:project_dom/models/books.dart';

class BookCard extends StatelessWidget {
  const BookCard({required this.book, super.key});

  final Book book;

  @override
  Widget build(BuildContext context) {
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
              if (constraints.maxWidth >= 650)
                Text(
                    '${book.availableCopies} out of ${book.totalCopies} copies available'),
              if (constraints.maxWidth < 650 && constraints.maxWidth >= 490)
                Text('available ${book.availableCopies} / ${book.totalCopies}'),
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
