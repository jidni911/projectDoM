class Notice {
  int? id;
  String title;
  String description;
  String date;
  String? imageUrl;

  Notice(
      {this.id,
      required this.title,
      required this.description,
      required this.date,
      this.imageUrl});

  @override
  String toString() {
    return 'Notice(id: $id, title: $title, description: $description, date: $date, imageUrl: $imageUrl)';
  }
}
