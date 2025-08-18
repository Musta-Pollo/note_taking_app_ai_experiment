import 'package:flutter/material.dart';
import '../../core/database/tables/notes_table.dart';

/// UI extensions for SortType to provide icons and labels
extension SortTypeUI on SortType {
  /// Get sort icon for display
  IconData getIcon() {
    return switch (this) {
      SortType.dateDesc => Icons.access_time,
      SortType.dateAsc => Icons.schedule,
      SortType.nameAsc => Icons.sort_by_alpha,
      SortType.nameDesc => Icons.sort_by_alpha,
    };
  }

  /// Get sort label for display
  String getLabel() {
    return switch (this) {
      SortType.dateDesc => 'Recent First',
      SortType.dateAsc => 'Oldest First',
      SortType.nameAsc => 'A to Z',
      SortType.nameDesc => 'Z to A',
    };
  }
}