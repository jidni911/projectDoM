// import 'dart:io';
// import 'dart:math';

// import 'package:project_dom/models/books.dart';

class BookRequest {
  int? id;
  int userId;
  int bookId;
  DateTime issueDate;
  DateTime dueDate;
  DateTime? returnDate;
  RequestStatus status;
  double? fineAmount;

  BookRequest({
    this.id,
    required this.userId,
    required this.bookId,
    required this.issueDate,
    required this.dueDate,
    this.returnDate,
    required this.status,
    this.fineAmount,
  });
}

enum RequestStatus { issued, claimed, returned }

// Future<void> main() async {
//   String temp = "";
//   var books = demoBooks;
//   int id = 1;
//   for (var book in books) {
//     int rentedCopies = book.totalCopies - book.availableCopies;
//     int randomNumber = Random().nextInt(20);
//     for (int i = 0; i < rentedCopies + randomNumber; i++) {
//       int userId = Random().nextInt(20) + 1;
//       var issueDate =
//           DateTime.now().subtract(Duration(days: Random().nextInt(7)));
//       var dueDate = issueDate.add(Duration(days: 7));
//       var status = Random().nextBool()
//           ? 'RequestStatus.issued'
//           : 'RequestStatus.claimed';
//       temp +=
//           'BookRequest(\nid: ${id++},\nuserId: $userId,\nbookId: ${book.id},\nissueDate: DateTime.parse("$issueDate"),\ndueDate: DateTime.parse("$dueDate"),\nstatus: $status,\nfineAmount: 0.0,\n),\n';
//     }
//   }

//   File file = File('output.txt'); // Creates or opens 'output.txt'
//   await file.writeAsString(temp); // Writes the date

//   print('Date written to file successfully!');

//   // print(a.dueDate.toString());
// }
