import 'package:flutter/material.dart';
import 'package:project_dom/models/books.dart';
import 'package:project_dom/service/book_service.dart';

class BookCard extends StatelessWidget {
  const BookCard(
      {required this.book,
      super.key,
      required this.borrowed,
      required this.loadBorrowList});
  final Book book;
  final Function() loadBorrowList;
  final bool borrowed;

  void borrowBook(BuildContext context) async {
    BookService bookService = BookService();
    if (book.id == null) return;
    bool? borrowed = await bookService.borrowBook(book.id!);
    if (borrowed == null) return;
    if (borrowed) {
      loadBorrowList();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Book borrowed successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to borrow book!')),
      );
    }
  }

  void showBookDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  if (book.imageUrl != null)
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          book.imageUrl!,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    book.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'by ${book.author}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const Divider(height: 30, thickness: 1),
                  _buildDetailRow('ISBN', book.isbn),
                  _buildDetailRow('Publisher', book.publisher),
                  _buildDetailRow(
                    'Published Date',
                    _formatDate(book.publishedDate),
                  ),
                  _buildDetailRow('Category', book.category),
                  _buildDetailRow('Language', book.language),
                  _buildDetailRow(
                    'Shelf Location',
                    book.shelfLocation,
                  ),
                  _buildDetailRow(
                    'Available Copies',
                    book.availableCopies.toString(),
                  ),
                  _buildDetailRow(
                    'Total Copies',
                    book.totalCopies.toString(),
                  ),
                  if (book.createdAt != null)
                    _buildDetailRow(
                      'Added On',
                      _formatDate(book.createdAt!),
                    ),
                  if (book.updatedAt != null)
                    _buildDetailRow(
                      'Last Updated',
                      _formatDate(book.updatedAt!),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              '$title:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 350) {
          return Text(
              'Cant show book card\n with width ${constraints.maxWidth.ceil()}, \n contact developer');
        } else {
          return ListTile(
            leading: book.imageUrl != null
                ? Image(
                    image: NetworkImage(book.imageUrl!),
                    height: 50,
                    width: 50,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.book,
                      size: 50,
                    ),
                  )
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
              if (constraints.maxWidth >= 850 &&
                  book.availableCopies > 0 &&
                  !borrowed)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      borrowBook(context);
                    },
                    child: Text('Borrow'),
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
                    if (book.availableCopies > 0 && !borrowed)
                      PopupMenuItem(
                        child: ElevatedButton(
                          onPressed: () {
                            borrowBook(context);
                          },
                          child: Text('Borrow'),
                        ),
                      ),
                  ],
                )
            ]),
            onTap: () => showBookDetails(context),
          );
        }
      },
    );
  }
}
