// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:semaphoreci_flutter_demo/models/todo_item.dart';
import 'package:semaphoreci_flutter_demo/viewmodels/todo_viewmodel.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    this.todoViewModel,
  });

  final TodoViewModel? todoViewModel;

  List<TodoItem> get todos => todoViewModel != null ? todoViewModel!.todos : [];
}
