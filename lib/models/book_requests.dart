// import 'dart:io';
// import 'dart:math';

// import 'package:project_dom/models/books.dart';

import 'package:project_dom/models/books.dart';
import 'package:project_dom/models/users.dart';

class BookRequest {
  int? id;
  User user;
  Book book;
  DateTime? issueDate;
  DateTime? dueDate;
  DateTime? returnDate;
  RequestStatus status;
  double? fineAmount;

  BookRequest({
    this.id,
    required this.user,
    required this.book,
    this.issueDate,
    this.dueDate,
    this.returnDate,
    required this.status,
    this.fineAmount,
  });

  static BookRequest fromJson(json) {
    return BookRequest(
      id: json['id'],
      user: User.fromJson(json['user']),
      book: Book.fromJson(json['book']),
      issueDate:
          json['issueDate'] != null ? DateTime.parse(json['issueDate']) : null,
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      returnDate: json['returnDate'] != null
          ? DateTime.parse(json['returnDate'])
          : null,
      status: RequestStatusExtension.fromValue(json['status']),
      fineAmount: json['fineAmount'],
    );
  }
}

enum RequestStatus { requested, issued, claimed, returned }

extension RequestStatusExtension on RequestStatus {
  String get value {
    switch (this) {
      case RequestStatus.requested:
        return "REQUESTED";
      case RequestStatus.issued:
        return "ISSUED";
      case RequestStatus.claimed:
        return "CLAIMED";
      case RequestStatus.returned:
        return "RETURNED";
    }
  }

  static RequestStatus fromValue(String value) {
    switch (value.toUpperCase()) {
      case "REQUESTED":
        return RequestStatus.requested;
      case "ISSUED":
        return RequestStatus.issued;
      case "CLAIMED":
        return RequestStatus.claimed;
      case "RETURNED":
        return RequestStatus.returned;
      default:
        throw Exception("Invalid RequestStatus: $value");
    }
  }
}

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
