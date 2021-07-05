import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:semaphoreci_flutter_demo/features/home/home_page.dart';
import 'package:semaphoreci_flutter_demo/features/home/home_viewmodel.dart';
import 'package:semaphoreci_flutter_demo/models/todo_item.dart';
import 'package:semaphoreci_flutter_demo/viewmodels/todo_viewmodel.dart';

// ignore_for_file: cascade_invocations
void main() {
  testWidgets(
    'Should display the items in the list',
    (WidgetTester tester) async {
      // Arrange

      final todoViewModel = TodoViewModel();
      final item = TodoItem(
        id: 1,
        title: 'Title',
        description: 'Description',
        createdAt: 1,
        updatedAt: 1,
      );
      final titleFinder = find.text('Title');
      final typeFinder = find.byType(ListTile);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => todoViewModel,
              ),
              ChangeNotifierProxyProvider<TodoViewModel, HomeViewModel>(
                create: (_) => HomeViewModel(
                  todoViewModel: todoViewModel,
                ),
                update: (_, todo, __) => HomeViewModel(todoViewModel: todo),
              ),
            ],
            child: HomePage(),
          ),
        ),
      );

      todoViewModel.addItemToList(item);      
      todoViewModel.addItemToList(item);
      todoViewModel.addItemToList(item);

      await tester.pumpAndSettle();

      // Assert
      expect(titleFinder, findsNWidgets(3));
      expect(typeFinder, findsNWidgets(3));
    },
  );
}
