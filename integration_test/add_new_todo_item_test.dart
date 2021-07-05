import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:semaphoreci_flutter_demo/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    "Should display the newly added item in the list",
    (WidgetTester tester) async {
      // Arrange
      app.main();
      await tester.pumpAndSettle();
      final addFinder = find.byKey(ValueKey('button.add'));
      final titleFinder = find.byKey(ValueKey('input.title'));
      final descriptionFinder = find.byKey(ValueKey('input.description'));
      final saveFinder = find.byKey(ValueKey('button.save'));

      // Act
      await tester.tap(addFinder);
      await tester.pumpAndSettle();

      await tester.enterText(titleFinder, 'This is a title');
      await tester.pumpAndSettle();

      await tester.enterText(descriptionFinder, 'This is a description');
      await tester.pumpAndSettle();

      await tester.tap(saveFinder);
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('This is a title'), findsOneWidget);
      expect(find.text('This is a description'), findsOneWidget);
    },
  );
}
