class Assignment {
  final int? id;
  final String title;
  final List<String> description;
  final List<String>? attachments;
  final String date;
  final String dueDate;
  final String assignedBy;
  final String assignedTo;

  Assignment(
      {this.id,
      required this.title,
      required this.description,
      this.attachments,
      required this.date,
      required this.dueDate,
      required this.assignedBy,
      required this.assignedTo});
}

List<Assignment> demoAssignments = [
  Assignment(
      id: 1,
      title: 'Theory of Rings and modules',
      description: ['Chapter 1, Q1', 'Chapter 2, Q2', 'Chapter 3, Q3'],
      // attachments: ['Attachment 1', 'Attachment 2'],
      date: '2022-01-01',
      dueDate: '2022-01-10',
      assignedBy: 'Shahanaz Parvin',
      assignedTo: 'Honurs 4th year'),
  Assignment(
      id: 2,
      title: 'Linear Algebra',
      description: ['Chapter 1, Q1', 'Chapter 2, Q2', 'Chapter 3, Q3'],
      // attachments: ['Attachment 1', 'Attachment 2'],
      date: '2022-01-01',
      dueDate: '2022-01-10',
      assignedBy: 'Ayub Ali',
      assignedTo: 'Honurs 3rd year'),
  Assignment(
      id: 3,
      title: 'Calculus',
      description: ['Chapter 1, Q1', 'Chapter 2, Q2', 'Chapter 3, Q3'],
      // attachments: ['Attachment 1', 'Attachment 2'],
      date: '2022-01-01',
      dueDate: '2022-01-10',
      assignedBy: 'Saleh Ahmed',
      assignedTo: 'Honurs 1st year'),
  Assignment(
      id: 4,
      title: 'Real Analysis',
      description: ['Chapter 1, Q1', 'Chapter 2, Q2', 'Chapter 3, Q3'],
      // attachments: ['Attachment 1', 'Attachment 2'],
      date: '2022-01-01',
      dueDate: '2022-01-10',
      assignedBy: 'Al Amin Mir',
      assignedTo: 'Honurs 2th year'),
];
