class Todo {
  final String id;
  String title;
  bool isCompleted;
  String? imagePath; // New field for storing image path

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.imagePath, // Optional field for the image
  });
}
