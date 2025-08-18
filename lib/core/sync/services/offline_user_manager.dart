import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../providers/core_providers.dart';

part 'offline_user_manager.g.dart';

/// Service responsible for handling offline user ID corrections
@riverpod
class OfflineUserManager extends _$OfflineUserManager {
  @override
  void build() {
    // Service instance
  }

  /// Corrects 'offline-user' user_id values to the current authenticated user ID
  ///
  /// The changes data structure format is:
  /// tablename: {
  ///   created: [...],
  ///   deleted: [...],
  ///   updated: [...]
  /// }
  Map<String, dynamic> correctOfflineUserIds(Map<String, dynamic> changes) {
    final currentUserId = ref.read(currentUserIdProvider);

    // If no authenticated user, return unchanged
    if (currentUserId == null) {
      return changes;
    }

    // Deep copy and correct the changes
    final correctedChanges = <String, dynamic>{};

    for (final tableName in changes.keys) {
      final tableChanges = changes[tableName] as Map<String, dynamic>;
      final correctedTableChanges = <String, dynamic>{};

      for (final changeType in tableChanges.keys) {
        final records = tableChanges[changeType] as List;
        final correctedRecords = records.map((record) {
          if (record is Map<String, dynamic> &&
              record['user_id'] == 'offline-user') {
            // Create a copy of the record with corrected user_id
            return Map<String, dynamic>.from(record)
              ..['user_id'] = currentUserId;
          }
          return record;
        }).toList();

        correctedTableChanges[changeType] = correctedRecords;
      }

      correctedChanges[tableName] = correctedTableChanges;
    }

    return correctedChanges;
  }
}
