import 'package:flutter_test/flutter_test.dart';
import 'package:semaphoreci_flutter_demo/models/todo_item.dart';
import 'package:semaphoreci_flutter_demo/viewmodels/todo_viewmodel.dart';

void main() {
  test('Should show default empty todos array', () {
    // Arrange
    final todoViewModel = TodoViewModel();

    // Act
    // Do nothing

    // Assert
    expect(todoViewModel.todos.length, 0);
  });

  test('Should get all items added to the list', () {
    // Arrange
    final todoViewModel = TodoViewModel();
    final item = TodoItem(
      id: 1,
      title: 'Buy groceries',
      description: 'Go to the mall and shop for next month’s stock.',
      createdAt: 1,
      updatedAt: 1,
    );

    // Act
    todoViewModel.addItemToList(item);
    todoViewModel.addItemToList(item);
    todoViewModel.addItemToList(item);

    // Assert
    expect(todoViewModel.todos.length, 3);
  });

  test('Should update one item in the list', () {
    // Arrange
    final todoViewModel = TodoViewModel();
    final item = TodoItem(
      id: 1,
      title: 'Buy groceries',
      description: 'Go to the mall and shop for next month’s stock.',
      createdAt: 1,
      updatedAt: 1,
    );
    final item2Old = TodoItem(
      id: 2,
      title: 'Buy groceries old',
      description: 'Go to the mall and shop for next month’s stock old.',
      createdAt: 1,
      updatedAt: 1,
    );
    final item2New = TodoItem(
      id: 2,
      title: 'Buy groceries new',
      description: 'Go to the mall and shop for next month’s stock new.',
      createdAt: 1,
      updatedAt: 1,
    );

    // Act
    todoViewModel.addItemToList(item);
    todoViewModel.addItemToList(item);
    todoViewModel.addItemToList(item2Old);
    todoViewModel.updateItem(item2New);

    // Assert
    expect(todoViewModel.todos[2].title, 'Buy groceries new');
    expect(
      todoViewModel.todos[2].description,
      'Go to the mall and shop for next month’s stock new.',
    );
  });

  test('Should delete one item by id from the list', () {
    // Arrange
    final todoViewModel = TodoViewModel();
    final item = TodoItem(
      id: 1,
      title: 'Buy groceries',
      description: 'Go to the mall and shop for next month’s stock.',
      createdAt: 1,
      updatedAt: 1,
    );
    final itemToDelete = TodoItem(
      id: 2,
      title: 'Buy groceries deleted',
      description: 'Go to the mall and shop for next month’s stock deleted.',
      createdAt: 1,
      updatedAt: 1,
    );

    // Act
    todoViewModel.addItemToList(item);
    todoViewModel.addItemToList(item);
    todoViewModel.addItemToList(itemToDelete);
    todoViewModel.deleteItemById(itemToDelete.id);

    // Assert
    expect(todoViewModel.todos.length, 2);
  });

  test('Should delete all items from the list', () {
    // Arrange
    final todoViewModel = TodoViewModel();
    final item = TodoItem(
      id: 1,
      title: 'Buy groceries',
      description: 'Go to the mall and shop for next month’s stock.',
      createdAt: 1,
      updatedAt: 1,
    );

    // Act
    todoViewModel.addItemToList(item);
    todoViewModel.addItemToList(item);
    todoViewModel.addItemToList(item);
    todoViewModel.deleteAllItems();

    // Assert
    expect(todoViewModel.todos.length, 0);
  });
}
