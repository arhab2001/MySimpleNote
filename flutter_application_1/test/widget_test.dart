import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MySimpleNoteApp());

    // Verify that the initial screen loads correctly.
    expect(find.text('MySimpleNote'), findsOneWidget);

    // Tap the '+' icon to add a new note.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify that we navigated to the note edit screen.
    expect(find.text('New Note'), findsOneWidget);

    // Enter a title and content for the new note.
    await tester.enterText(find.byType(TextField).first, 'Test Title');
    await tester.enterText(find.byType(TextField).last, 'Test Content');

    // Save the note.
    await tester.tap(find.text('Save Note'));
    await tester.pumpAndSettle();

    // Verify that the new note is displayed on the home screen.
    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Content'), findsOneWidget);
  });
}
