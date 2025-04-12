class Book {
  int? id;
  String title;
  String author;
  String isbn;
  String publisher;
  DateTime publishedDate;
  String category;
  String language;
  int totalCopies;
  int availableCopies;
  String shelfLocation;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.isbn,
    required this.publisher,
    required this.publishedDate,
    required this.category,
    required this.language,
    required this.totalCopies,
    required this.availableCopies,
    required this.shelfLocation,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      isbn: json['isbn'],
      publisher: json['publisher'],
      publishedDate: DateTime.parse(json['published_date']),
      category: json['category'],
      language: json['language'],
      totalCopies: json['total_copies'],
      availableCopies: json['available_copies'],
      shelfLocation: json['shelf_location'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'isbn': isbn,
      'publisher': publisher,
      'published_date': publishedDate.toIso8601String(),
      'category': category,
      'language': language,
      'total_copies': totalCopies,
      'available_copies': availableCopies,
      'shelf_location': shelfLocation,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'image_url': imageUrl,
    };
  }

  @override
  String toString() {
    return 'Book{id: $id, title: $title, author: $author, isbn: $isbn, publisher: $publisher, publishedDate: $publishedDate, category: $category, language: $language, totalCopies: $totalCopies, availableCopies: $availableCopies, shelfLocation: $shelfLocation, createdAt: $createdAt, updatedAt: $updatedAt, imageUrl: $imageUrl}';
  }
}

List<Book> demoBooks = [
  Book(
    id: 1,
    title: 'The Great Gatsby',
    author: 'F. Scott Fitzgerald',
    isbn: '978-3-16-148410-0',
    publisher: 'Scribner',
    publishedDate: DateTime(1925, 4, 10),
    category: 'Fiction',
    language: 'English',
    totalCopies: 10,
    availableCopies: 5,
    shelfLocation: 'A1',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/The_Great_Gatsby_Cover_1925_Retouched.jpg/330px-The_Great_Gatsby_Cover_1925_Retouched.jpg',
  ),
  Book(
    id: 2,
    title: 'To Kill a Mockingbird',
    author: 'Harper Lee',
    isbn: '978-0-06-112004-3',
    publisher: 'J. B. Lippincott & Co.',
    publishedDate: DateTime(1960, 7, 11),
    category: 'Fiction',
    language: 'English',
    totalCopies: 8,
    availableCopies: 3,
    shelfLocation: 'B2',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/To_Kill_a_Mockingbird_%28first_edition_cover%29.jpg/330px-To_Kill_a_Mockingbird_%28first_edition_cover%29.jpg',
  ),
  Book(
    id: 3,
    title: '1984',
    author: 'George Orwell',
    isbn: '978-0-06-112004-3',
    publisher: 'Secker & Warburg',
    publishedDate: DateTime(1949, 6, 8),
    category: 'Fiction',
    language: 'English',
    totalCopies: 6,
    availableCopies: 2,
    shelfLocation: 'C3',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    imageUrl:
        'https://static-01.daraz.com.bd/p/83cb389fea6e3d5df2f85d9bee2949fc.jpg',
  ),
  Book(
    id: 4,
    title: 'The Catcher in the Rye',
    author: 'J.D. Salinger',
    isbn: '978-0-06-112004-3',
    publisher: 'Little, Brown and Company',
    publishedDate: DateTime(1951, 7, 16),
    category: 'Fiction',
    language: 'English',
    totalCopies: 9,
    availableCopies: 4,
    shelfLocation: 'D4',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/The_Catcher_in_the_Rye_%281951%2C_first_edition_cover%29.jpg/330px-The_Catcher_in_the_Rye_%281951%2C_first_edition_cover%29.jpg',
  ),
  Book(
    id: 5,
    title: 'The Lord of the Rings',
    author: 'J.R.R. Tolkien',
    isbn: '978-0-06-112004-3',
    publisher: 'Houghton Mifflin Harcourt',
    publishedDate: DateTime(1954, 7, 29),
    category: 'Fiction',
    language: 'English',
    totalCopies: 7,
    availableCopies: 3,
    shelfLocation: 'E5',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/en/f/fb/Lord_Rings_Fellowship_Ring.jpg',
  ),
  Book(
    id: 6,
    title: 'Pride and Prejudice',
    author: 'Jane Austen',
    isbn: '978-0-06-112004-3',
    publisher: 'Penguin Classics',
    publishedDate: DateTime(1813, 1, 28),
    category: 'Fiction',
    language: 'English',
    totalCopies: 5,
    availableCopies: 2,
    shelfLocation: 'F6',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/en/0/03/Prideandprejudiceposter.jpg',
  ),
  Book(
    id: 7,
    title: 'The Hobbit',
    author: 'J.R.R. Tolkien',
    isbn: '978-0-06-112004-3',
    publisher: 'Houghton Mifflin Harcourt',
    publishedDate: DateTime(1937, 9, 21),
    category: 'Fiction',
    language: 'English',
    totalCopies: 6,
    availableCopies: 3,
    shelfLocation: 'G7',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/en/a/a9/The_Hobbit_trilogy_dvd_cover.jpg',
  ),
  Book(
    id: 8,
    title: 'The Alchemist',
    author: 'Paulo Coelho',
    isbn: '978-0-06-112004-3',
    publisher: 'HarperCollins',
    publishedDate: DateTime(1988, 7, 24),
    category: 'Fiction',
    language: 'English',
    totalCopies: 8,
    availableCopies: 4,
    shelfLocation: 'H8',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/TheAlchemist.jpg/330px-TheAlchemist.jpg',
  ),
  Book(
    id: 9,
    title: 'The Hobbit',
    author: 'J.R.R. Tolkien',
    isbn: '978-0-06-112004-3',
    publisher: 'Houghton Mifflin Harcourt',
    publishedDate: DateTime(1937, 9, 21),
    category: 'Fiction',
    language: 'English',
    totalCopies: 6,
    availableCopies: 3,
    shelfLocation: 'I9',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Book(
    id: 10,
    title: 'To Kill a Mockingbird',
    author: 'Harper Lee',
    isbn: '978-0-06-112004-3',
    publisher: 'J. B. Lippincott & Co.',
    publishedDate: DateTime(1960, 7, 11),
    category: 'Fiction',
    language: 'English',
    totalCopies: 8,
    availableCopies: 3,
    shelfLocation: 'J10',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
