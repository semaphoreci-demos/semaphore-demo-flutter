import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:semaphoreci_flutter_demo/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Should display the newly added item in the list',
    (WidgetTester tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle();
      final addFinder = find.byKey(const ValueKey('button.add'));
      final titleFinder = find.byKey(const ValueKey('input.title'));
      final descriptionFinder = find.byKey(const ValueKey('input.description'));
      final saveFinder = find.byKey(const ValueKey('button.save'));

      // Act
      await tester.tap(addFinder);
      await tester.pumpAndSettle();

      await tester.enterText(titleFinder, 'Buy groceries');
      await tester.pumpAndSettle();

      await tester.enterText(
        descriptionFinder,
        'Go to the mall and shop for next month’s stock.',
      );
      await tester.pumpAndSettle();

      await tester.tap(saveFinder);
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Buy groceries'), findsOneWidget);
      expect(
        find.text('Go to the mall and shop for next month’s stock.'),
        findsOneWidget,
      );
    },
  );
}
