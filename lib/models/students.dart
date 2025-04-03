import 'package:project_dom/models/users.dart';

class Student extends User {
  int classRoll;
  int registration;
  String section;
  int year;
  String session;

  Student(int? id, String name, this.classRoll, this.registration, this.section,
      this.year, String imageUrl, this.session)
      : super(id: id, fullName: name, imageUrl: imageUrl);

  String getYear() {
    switch (year) {
      case 1:
        return 'First year';
      case 2:
        return 'Second year';
      case 3:
        return 'Third year';
      case 4:
        return 'Fourth year';
      case 5:
        return 'MSc First year';
      default:
        return '??';
    }
  }
}

List<Student> demoStudents = [
  Student(
      1,
      'Shuvo',
      1,
      1,
      'A',
      1,
      'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?w=1000&q=80',
      '2022-2023'),
  Student(
      2,
      'Saroar',
      2,
      2,
      'B',
      1,
      'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=1000&q=80',
      '2022-2023'),
  Student(
      3,
      'Ashik',
      3,
      3,
      'C',
      1,
      'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=1000&q=80',
      '2022-2023'),
  Student(
      4,
      'Tonmoy',
      4,
      4,
      'D',
      1,
      'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?w=1000&q=80',
      '2022-2023'),
  Student(
      5,
      'Karim',
      5,
      5,
      'E',
      1,
      'https://images.unsplash.com/photo-1502691876148-a84978e59af8?w=1000&q=80',
      '2022-2023'),
  Student(
      6,
      'Jamal',
      6,
      6,
      'A',
      1,
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=1000&q=80',
      '2023-2024'),
  Student(
      7,
      'Rahim',
      7,
      7,
      'B',
      1,
      'https://images.unsplash.com/photo-1502691876148-a84978e59af8?w=1000&q=80',
      '2023-2024'),
  Student(
      8,
      'Salman',
      8,
      8,
      'C',
      1,
      'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=1000&q=80',
      '2023-2024'),
  Student(
      9,
      'Abir',
      9,
      9,
      'D',
      1,
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=1000&q=80',
      '2023-2024'),
  Student(
      10,
      'Rafi',
      10,
      10,
      'E',
      1,
      'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=1000&q=80',
      '2023-2024'),
  Student(
      11,
      'Hasan',
      11,
      11,
      'A',
      1,
      'https://images.unsplash.com/photo-1524604269826-f47c462b5242?w=1000&q=80',
      '2024-2025'),
  Student(
      12,
      'Mehedi',
      12,
      12,
      'B',
      1,
      'https://images.unsplash.com/photo-1501594907352-04cda38ebc29?w=1000&q=80',
      '2024-2025'),
  Student(
      13,
      'Rakib',
      13,
      13,
      'C',
      1,
      'https://images.unsplash.com/photo-1514846326710-096e3a4430b4?w=1000&q=80',
      '2024-2025'),
  Student(
      14,
      'Nayeem',
      14,
      14,
      'D',
      1,
      'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=1000&q=80',
      '2024-2025'),
  Student(
      15,
      'Rahat',
      15,
      15,
      'E',
      1,
      'https://images.unsplash.com/photo-1542202229-98e776a55f68?w=1000&q=80',
      '2024-2025'),
  Student(
      16,
      'Tuhin',
      16,
      16,
      'A',
      1,
      'https://images.unsplash.com/photo-1554151228-14d9def656e4?w=1000&q=80',
      '2025-2026'),
  Student(
      17,
      'Bishal',
      17,
      17,
      'B',
      1,
      'https://images.unsplash.com/photo-1542909168-82c3e7fdca5c?w=1000&q=80',
      '2025-2026'),
  Student(
      18,
      'Shahin',
      18,
      18,
      'C',
      1,
      'https://images.unsplash.com/photo-1547931727-8be1db2820d1?w=1000&q=80',
      '2025-2026'),
  Student(
      19,
      'Saiful',
      19,
      19,
      'D',
      1,
      'https://images.unsplash.com/photo-1519408469771-2586093c3f14?w=1000&q=80',
      '2025-2026'),
  Student(
      20,
      'Hridoy',
      20,
      20,
      'E',
      1,
      'https://images.unsplash.com/photo-1573495612894-4a03a6b4b9b4?w=1000&q=80',
      '2025-2026'),
];
