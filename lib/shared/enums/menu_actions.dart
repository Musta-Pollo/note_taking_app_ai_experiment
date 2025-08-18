import 'package:flutter/material.dart';
import '../constants/k.dart';
import '../../core/database/tables/notes_table.dart';

/// Enum for note card menu actions
enum NoteMenuAction {
  edit(K.edit, Icons.edit),
  delete(K.delete, Icons.delete),
  share(K.share, Icons.share),
  duplicate('Duplicate', Icons.copy),
  favorite('Favorite', Icons.favorite_border);
  
  const NoteMenuAction(this.label, this.icon);
  
  final String label;
  final IconData icon;
}

/// Enum for category menu actions
enum CategoryMenuAction {
  edit(K.edit, Icons.edit),
  delete(K.delete, Icons.delete),
  viewNotes('View Notes', Icons.notes);
  
  const CategoryMenuAction(this.label, this.icon);
  
  final String label;
  final IconData icon;
}

/// Enum for sort actions
enum SortMenuAction {
  dateDesc('Newest First', Icons.arrow_downward),
  dateAsc('Oldest First', Icons.arrow_upward),
  nameAsc('Name A-Z', Icons.sort_by_alpha),
  nameDesc('Name Z-A', Icons.sort);
  
  const SortMenuAction(this.label, this.icon);
  
  final String label;
  final IconData icon;
  
  SortType get sortType {
    switch (this) {
      case SortMenuAction.dateDesc:
        return SortType.dateDesc;
      case SortMenuAction.dateAsc:
        return SortType.dateAsc;
      case SortMenuAction.nameAsc:
        return SortType.nameAsc;
      case SortMenuAction.nameDesc:
        return SortType.nameDesc;
    }
  }
}

/// Enum for editor menu actions
enum EditorMenuAction {
  export('Export', Icons.download),
  refresh('Refresh', Icons.refresh);
  
  const EditorMenuAction(this.label, this.icon);
  
  final String label;
  final IconData icon;
}

/// Enum for note page actions
enum NotePageAction {
  convert('Convert to Rich Note', Icons.upgrade),
  delete('Delete', Icons.delete);
  
  const NotePageAction(this.label, this.icon);
  
  final String label;
  final IconData icon;
}