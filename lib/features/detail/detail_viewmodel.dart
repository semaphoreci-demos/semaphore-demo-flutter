import 'package:flutter/material.dart';
import 'package:semaphoreci_flutter_demo/features/detail/detail_page.dart';
import 'package:semaphoreci_flutter_demo/models/todo_item.dart';
import 'package:semaphoreci_flutter_demo/viewmodels/todo_viewmodel.dart';

// ignore_for_file: public_member_api_docs
class DetailViewModel extends ChangeNotifier {
  DetailViewModel({
    required this.todoViewModel,
  });

  final TodoViewModel? todoViewModel;

  DetailPageType type = DetailPageType.add;

  TodoItem? itemEditing;

  String title = '';

  String description = '';

  bool _isDisposed = false;

  bool get isSavingAllowed => title.isNotEmpty && description.isNotEmpty;

  String get saveLabel => type == DetailPageType.add ? 'Save' : 'Update';

  void enterTitle(String title) {
    this.title = title;
    if (!_isDisposed) notifyListeners();
  }

  void enterDescription(String description) {
    this.description = description;
    if (!_isDisposed) notifyListeners();
  }

  void setItemEditing(TodoItem item) {
    itemEditing = item;
    if (!_isDisposed) notifyListeners();
  }

  void setDetailType(DetailPageType type) {
    this.type = type;
  }

  void saveItem() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    switch (type) {
      case DetailPageType.add:
        final item = TodoItem(
          id: timestamp,
          title: title,
          description: description,
          createdAt: timestamp,
          updatedAt: timestamp,
        );

        todoViewModel?.addItemToList(item);
        break;
      case DetailPageType.edit:
        final item = TodoItem(
          id: itemEditing!.id,
          title: title,
          description: description,
          createdAt: itemEditing!.createdAt,
          updatedAt: timestamp,
        );

        todoViewModel?.updateItem(item);
        break;
    }
  }

  void deleteItemById(int id) => todoViewModel?.deleteItemById(id);

  void reset() {
    type = DetailPageType.add;
    title = '';
    description = '';
    _isDisposed = false;
  }

  @override
  void dispose() {
    super.dispose();
    _isDisposed = true;
  }
}
