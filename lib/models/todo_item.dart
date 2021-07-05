// ignore_for_file: public_member_api_docs
// ignore_for_file: sort_constructors_first
class TodoItem {
  final int id;
  final String title;
  final String description;
  final int createdAt;
  final int updatedAt;

  TodoItem({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });
}
