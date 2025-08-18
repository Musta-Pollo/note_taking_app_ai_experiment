// /// Test utilities and helpers for the note taking app
// /// Provides common setup, mocks, and utilities for testing

// import 'dart:io';
// import 'package:drift/drift.dart';
// import 'package:drift/native.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:note_taking_app/core/database/app_database.dart';
// import 'package:note_taking_app/features/notes/domain/entities/category_entity.dart';
// import 'package:note_taking_app/features/notes/domain/entities/note_entity.dart';
// import 'package:note_taking_app/core/database/tables/notes_table.dart';
// import 'package:note_taking_app/shared/types/result.dart';
// import 'package:sqlite3/sqlite3.dart';
// import 'package:uuid/uuid.dart';

// /// Creates an in-memory database for testing
// AppDatabase createTestDatabase() {
//   return AppDatabase.connect(DatabaseConnection(
//     NativeDatabase.memory(
//       setup: (database) {
//         database.execute('PRAGMA foreign_keys = ON');
//         database.execute('PRAGMA journal_mode = WAL');
//         database.execute('PRAGMA synchronous = NORMAL');
//       },
//     ),
//   ));
// }

// /// Test data factory for creating consistent test entities
// class TestDataFactory {
//   static const String testUserId = 'test-user-123';
//   static const String testCategoryId = 'test-category-123';
//   static const String testNoteId = 'test-note-123';

//   static CategoryEntity createTestCategory({
//     String? id,
//     String? name,
//     String? userId,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     bool isRemote = false,
//   }) {
//     final now = DateTime.now().toUtc();
//     return CategoryEntity(
//       id: id ?? const Uuid().v4(),
//       name: name ?? 'Test Category',
//       userId: userId ?? testUserId,
//       createdAt: createdAt ?? now,
//       updatedAt: updatedAt ?? now,
//       isRemote: isRemote,
//     );
//   }

//   static NoteEntity createTestNote({
//     String? id,
//     String? content,
//     String? categoryId,
//     String? userId,
//     NoteType? noteType,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     bool isRemote = false,
//   }) {
//     final now = DateTime.now().toUtc();
//     return NoteEntity(
//       id: id ?? const Uuid().v4(),
//       content: content ?? 'Test note content',
//       categoryId: categoryId ?? testCategoryId,
//       userId: userId ?? testUserId,
//       noteType: noteType ?? NoteType.simple,
//       createdAt: createdAt ?? now,
//       updatedAt: updatedAt ?? now,
//       isRemote: isRemote,
//     );
//   }

//   static List<CategoryEntity> createTestCategories(int count) {
//     return List.generate(count, (index) => createTestCategory(
//       id: 'category-$index',
//       name: 'Category $index',
//     ));
//   }

//   static List<NoteEntity> createTestNotes(int count, {String? categoryId}) {
//     return List.generate(count, (index) => createTestNote(
//       id: 'note-$index',
//       content: 'Note content $index',
//       categoryId: categoryId ?? testCategoryId,
//     ));
//   }
// }

// /// Test utilities for error handling
// class TestErrorFactory {
//   static NetworkError createNetworkError([String? message]) {
//     return NetworkError(
//       message: message ?? 'Test network error',
//       code: 'TEST_NETWORK_ERROR',
//     );
//   }

//   static DatabaseError createDatabaseError([String? message]) {
//     return DatabaseError(
//       message: message ?? 'Test database error',
//       code: 'TEST_DATABASE_ERROR',
//     );
//   }

//   static ValidationError createValidationError([String? field, String? message]) {
//     return ValidationError(
//       message: message ?? 'Test validation error',
//       field: field ?? 'test_field',
//       code: 'TEST_VALIDATION_ERROR',
//     );
//   }

//   static SyncError createSyncError([String? message]) {
//     return SyncError(
//       message: message ?? 'Test sync error',
//       code: 'TEST_SYNC_ERROR',
//     );
//   }
// }

// /// Helper extension for Result testing
// extension ResultTestHelpers<T> on Result<T> {
//   /// Asserts that this result is a success and returns the data
//   T expectSuccess() {
//     expect(isSuccess, isTrue, reason: 'Expected success but got: $this');
//     return data!;
//   }

//   /// Asserts that this result is a failure and returns the error
//   AppError expectFailure() {
//     expect(isFailure, isTrue, reason: 'Expected failure but got: $this');
//     return error!;
//   }

//   /// Asserts that this result is a success with specific data
//   void expectSuccessWithData(T expectedData) {
//     expect(isSuccess, isTrue, reason: 'Expected success but got: $this');
//     expect(data, equals(expectedData));
//   }

//   /// Asserts that this result is a failure with specific error type
//   void expectFailureOfType<E extends AppError>() {
//     expect(isFailure, isTrue, reason: 'Expected failure but got: $this');
//     expect(error, isA<E>());
//   }
// }

// /// Stream testing utilities
// class StreamTestHelpers {
//   /// Waits for a stream to emit a specific number of events and returns them
//   static Future<List<T>> collectEvents<T>(
//     Stream<T> stream,
//     int count, {
//     Duration timeout = const Duration(seconds: 5),
//   }) async {
//     final events = <T>[];
//     final completer = Completer<List<T>>();
    
//     late StreamSubscription<T> subscription;
    
//     subscription = stream.listen(
//       (event) {
//         events.add(event);
//         if (events.length >= count) {
//           subscription.cancel();
//           completer.complete(events);
//         }
//       },
//       onError: (error) {
//         subscription.cancel();
//         completer.completeError(error);
//       },
//     );

//     // Set up timeout
//     Timer(timeout, () {
//       if (!completer.isCompleted) {
//         subscription.cancel();
//         completer.completeError(
//           TimeoutException('Stream did not emit $count events within $timeout'),
//         );
//       }
//     });

//     return completer.future;
//   }

//   /// Waits for the first event from a stream
//   static Future<T> firstEvent<T>(
//     Stream<T> stream, {
//     Duration timeout = const Duration(seconds: 5),
//   }) async {
//     final events = await collectEvents(stream, 1, timeout: timeout);
//     return events.first;
//   }
// }

// /// Platform channel mock helpers
// class PlatformChannelMocks {
//   static void setupMethodChannelMocks() {
//     TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
//         .setMockMethodCallHandler(
//       const MethodChannel('flutter/platform'),
//       (MethodCall methodCall) async {
//         switch (methodCall.method) {
//           case 'SystemChrome.setApplicationSwitcherDescription':
//           case 'SystemChrome.setSystemUIOverlayStyle':
//             return null;
//           default:
//             return null;
//         }
//       },
//     );
//   }

//   static void tearDownMocks() {
//     TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
//         .setMockMethodCallHandler(
//       const MethodChannel('flutter/platform'),
//       null,
//     );
//   }
// }

// /// Test suite setup helpers
// class TestSetup {
//   /// Standard setup for most tests
//   static void standardSetup() {
//     setUp(() {
//       PlatformChannelMocks.setupMethodChannelMocks();
//     });

//     tearDown(() {
//       PlatformChannelMocks.tearDownMocks();
//     });
//   }

//   /// Setup with database for database-related tests
//   static AppDatabase setupWithDatabase() {
//     late AppDatabase database;
    
//     setUp(() {
//       PlatformChannelMocks.setupMethodChannelMocks();
//       database = createTestDatabase();
//     });

//     tearDown(() async {
//       await database.close();
//       PlatformChannelMocks.tearDownMocks();
//     });

//     return database;
//   }
// }

// /// Custom matchers for testing
// class CustomMatchers {
//   /// Matcher for checking if a Result is a success
//   static Matcher isSuccess() => _IsSuccessMatcher();
  
//   /// Matcher for checking if a Result is a failure
//   static Matcher isFailure() => _IsFailureMatcher();
  
//   /// Matcher for checking if a Result contains specific data
//   static Matcher hasData<T>(T expectedData) => _HasDataMatcher<T>(expectedData);
  
//   /// Matcher for checking if a Result contains specific error type
//   static Matcher hasErrorOfType<E extends AppError>() => _HasErrorTypeMatcher<E>();
// }

// class _IsSuccessMatcher extends Matcher {
//   @override
//   bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
//     return item is Result && item.isSuccess;
//   }

//   @override
//   Description describe(Description description) {
//     return description.add('is a successful Result');
//   }
// }

// class _IsFailureMatcher extends Matcher {
//   @override
//   bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
//     return item is Result && item.isFailure;
//   }

//   @override
//   Description describe(Description description) {
//     return description.add('is a failed Result');
//   }
// }

// class _HasDataMatcher<T> extends Matcher {
//   final T expectedData;

//   _HasDataMatcher(this.expectedData);

//   @override
//   bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
//     return item is Result<T> && item.isSuccess && item.data == expectedData;
//   }

//   @override
//   Description describe(Description description) {
//     return description.add('is a successful Result with data: $expectedData');
//   }
// }

// class _HasErrorTypeMatcher<E extends AppError> extends Matcher {
//   @override
//   bool matches(dynamic item, Map<dynamic, dynamic> matchState) {
//     return item is Result && item.isFailure && item.error is E;
//   }

//   @override
//   Description describe(Description description) {
//     return description.add('is a failed Result with error of type: $E');
//   }
// }

// /// Mock classes for common dependencies
// class MockAppDatabase extends Mock implements AppDatabase {}

// class MockCategoryData extends Mock implements CategoryData {}

// class MockNoteData extends Mock implements NoteData {}

// /// Async testing utilities
// class AsyncTestHelpers {
//   /// Pumps the event loop multiple times to ensure async operations complete
//   static Future<void> pumpEventLoop([int times = 5]) async {
//     for (int i = 0; i < times; i++) {
//       await Future.delayed(Duration.zero);
//     }
//   }

//   /// Waits for a condition to become true within a timeout
//   static Future<void> waitForCondition(
//     bool Function() condition, {
//     Duration timeout = const Duration(seconds: 5),
//     Duration pollInterval = const Duration(milliseconds: 100),
//   }) async {
//     final stopwatch = Stopwatch()..start();
    
//     while (!condition() && stopwatch.elapsed < timeout) {
//       await Future.delayed(pollInterval);
//     }
    
//     if (!condition()) {
//       throw TimeoutException(
//         'Condition was not met within $timeout',
//         timeout,
//       );
//     }
//   }
// }