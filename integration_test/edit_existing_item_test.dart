import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:semaphoreci_flutter_demo/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Should display the newly updated item in the list',
    (WidgetTester tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle();
      final addFinder = find.byKey(const ValueKey('button.add'));
      final titleFinder = find.byKey(const ValueKey('input.title'));
      final descriptionFinder = find.byKey(const ValueKey('input.description'));
      final todoItemFinder = find.byType(ListTile).first;
      final saveFinder = find.byKey(const ValueKey('button.save'));

      // Act
      // Save
      await tester.tap(addFinder);
      await tester.pumpAndSettle();

      await tester.enterText(titleFinder, 'This is a title');
      await tester.pumpAndSettle();

      await tester.enterText(descriptionFinder, 'This is a description');
      await tester.pumpAndSettle();

      await tester.tap(saveFinder);
      await tester.pumpAndSettle();

      // Edit
      await tester.tap(todoItemFinder);
      await tester.pumpAndSettle();

      await tester.enterText(titleFinder, 'This is a new title');
      await tester.pumpAndSettle();

      await tester.enterText(descriptionFinder, 'This is a new description');
      await tester.pumpAndSettle();

      await tester.tap(saveFinder);
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('This is a new title'), findsOneWidget);
      expect(find.text('This is a new description'), findsOneWidget);
    },
  );
}
