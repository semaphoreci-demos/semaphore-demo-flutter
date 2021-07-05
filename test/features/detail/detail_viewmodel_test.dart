import 'package:flutter_test/flutter_test.dart';
import 'package:semaphoreci_flutter_demo/features/detail/detail_page.dart';
import 'package:semaphoreci_flutter_demo/features/detail/detail_viewmodel.dart';
import 'package:semaphoreci_flutter_demo/viewmodels/todo_viewmodel.dart';

void main() {
  test('Should show Save CTA when adding new item', () {
    // Arrange
    final todoViewModel = TodoViewModel();
    final detailViewModel = DetailViewModel(
      todoViewModel: todoViewModel,
    );

    // Act
    detailViewModel.setDetailType(DetailPageType.add);

    // Assert
    expect(detailViewModel.saveLabel, 'Save');
  });

  test('Should show Update CTA when editing an existing item', () {
    // Arrange
    final todoViewModel = TodoViewModel();
    final detailViewModel = DetailViewModel(
      todoViewModel: todoViewModel,
    );

    // Act
    detailViewModel.setDetailType(DetailPageType.edit);

    // Assert
    expect(detailViewModel.saveLabel, 'Update');
  });

  test('Should show update editable title and description', () {
    // Arrange
    final todoViewModel = TodoViewModel();
    final detailViewModel = DetailViewModel(
      todoViewModel: todoViewModel,
    );

    // Act
    detailViewModel.enterTitle('This is the new title');
    detailViewModel.enterDescription('This is the new description');

    // Assert
    expect(detailViewModel.title, 'This is the new title');
    expect(detailViewModel.description, 'This is the new description');
  });

  test('Should not allow to proceed when entered title and desc is empty', () {
    // Arrange
    final todoViewModel = TodoViewModel();
    final detailViewModel = DetailViewModel(
      todoViewModel: todoViewModel,
    );

    // Act
    detailViewModel.enterTitle('');
    detailViewModel.enterDescription('');

    // Assert
    expect(detailViewModel.isSavingAllowed, false);
  });

  test('Should increase list length when adding new item', () {
    // Arrange
    final todoViewModel = TodoViewModel();
    final detailViewModel = DetailViewModel(
      todoViewModel: todoViewModel,
    );
    expect(todoViewModel.todos.length, 0);

    // Act
    detailViewModel.enterTitle('This is the new title');
    detailViewModel.enterDescription('This is the new description');
    detailViewModel.saveItem();

    // Assert
    expect(todoViewModel.todos.length, 1);
  });

  test('Should update existing item in the list', () {
    // Arrange
    final todoViewModel = TodoViewModel();
    final detailViewModel = DetailViewModel(
      todoViewModel: todoViewModel,
    );

    // Act
    // Save
    detailViewModel.setDetailType(DetailPageType.add);
    detailViewModel.enterTitle('This is the old title');
    detailViewModel.enterDescription('This is the ol description');
    detailViewModel.saveItem();

    // Edit
    final item = todoViewModel.todos.first;
    detailViewModel.setDetailType(DetailPageType.edit);
    detailViewModel.setItemEditing(item);
    detailViewModel.enterTitle('This is the new title');
    detailViewModel.enterDescription('This is the new description');
    detailViewModel.saveItem();

    // Assert
    expect(todoViewModel.todos.length, 1);
    expect(detailViewModel.title, 'This is the new title');
    expect(detailViewModel.description, 'This is the new description');
  });

  test('Should reduce list length when removing an item', () {
    // Arrange
    final todoViewModel = TodoViewModel();
    final detailViewModel = DetailViewModel(
      todoViewModel: todoViewModel,
    );

    // Act
    // Save
    detailViewModel.setDetailType(DetailPageType.add);
    detailViewModel.enterTitle('This is the old title');
    detailViewModel.enterDescription('This is the ol description');
    detailViewModel.saveItem();
    expect(todoViewModel.todos.length, 1);

    // Delete
    final item = todoViewModel.todos.first;
    detailViewModel.deleteItemById(item.id);

    // Assert
    expect(todoViewModel.todos.length, 0);
  });

  test('Should reset to default detail page state', () {
    // Arrange
    final todoViewModel = TodoViewModel();
    final detailViewModel = DetailViewModel(
      todoViewModel: todoViewModel,
    );

    // Act
    detailViewModel.enterTitle('This is the new title');
    detailViewModel.enterDescription('This is the new description');
    detailViewModel.reset();

    // Assert
    expect(detailViewModel.type, DetailPageType.add);
    expect(detailViewModel.title, '');
    expect(detailViewModel.description, '');
  });
}
