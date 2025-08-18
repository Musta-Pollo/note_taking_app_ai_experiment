import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:note_taking_app/features/notes/presentation/pages/note_editor/note_editor_page.dart';

void main() {
  group('NoteEditorPage', () {
    testWidgets('renders with correct structure', (tester) async {
      // This test verifies the basic widget structure without complex dependencies

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: NoteEditorPage(noteId: 'test-note-id'),
        ),
      );

      // Assert basic structure is present
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);

      // Should show loading initially
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('app bar has correct title', (tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: NoteEditorPage(noteId: 'test-note-id'),
        ),
      );

      // Assert
      expect(find.text('Rich Text Editor'), findsOneWidget);
    });

    testWidgets('has save action in app bar menu', (tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: NoteEditorPage(noteId: 'test-note-id'),
        ),
      );

      // Find and tap the popup menu button
      final popupMenuButton = find.byType(PopupMenuButton<String>);
      expect(popupMenuButton, findsOneWidget);

      await tester.tap(popupMenuButton);
      await tester.pumpAndSettle();

      // Assert menu items exist
      expect(find.text('Save'), findsOneWidget);
      expect(find.text('Export'), findsOneWidget);
    });

    testWidgets('shows back button in app bar', (tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: NoteEditorPage(noteId: 'test-note-id'),
        ),
      );

      // Assert
      expect(find.byType(BackButton), findsOneWidget);
    });
  });

  group('NoteEditorPage Widget Structure', () {
    testWidgets('contains all expected UI elements', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: NoteEditorPage(noteId: 'test-id'),
        ),
      );

      // Check for main structural elements
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
    });
  });
}
