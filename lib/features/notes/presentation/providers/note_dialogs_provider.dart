import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/features/notes/presentation/dialogs/note_dialogs_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'note_dialogs_provider.g.dart';

@riverpod
NoteDialogsService noteDialogsServiceProvider(Ref ref) {
  return NoteDialogsService(ref);
}
