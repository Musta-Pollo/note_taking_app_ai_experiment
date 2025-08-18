import 'package:flutter/material.dart';
import '../constants/k.dart';
import '../enums/menu_actions.dart';

/// Generic popup menu widget with enum support
class AppPopupMenu<T extends Enum> extends StatelessWidget {
  const AppPopupMenu({
    super.key,
    required this.items,
    required this.onSelected,
    this.icon,
    this.tooltip,
    this.enabled = true,
  });
  
  final List<T> items;
  final void Function(T) onSelected;
  final Icon? icon;
  final String? tooltip;
  final bool enabled;
  
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      enabled: enabled,
      icon: icon,
      tooltip: tooltip,
      onSelected: onSelected,
      itemBuilder: (context) => items.map((item) {
        final label = _getLabel(item);
        final iconData = _getIcon(item);
        
        return PopupMenuItem<T>(
          value: item,
          child: ListTile(
            leading: Icon(iconData, size: K.iconSize20),
            title: Text(label),
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
        );
      }).toList(),
    );
  }
  
  String _getLabel(T item) {
    // Handle different enum types
    if (item is NoteMenuAction) {
      return item.label;
    } else if (item is CategoryMenuAction) {
      return item.label;
    } else if (item is SortMenuAction) {
      return item.label;
    } else if (item is EditorMenuAction) {
      return item.label;
    } else if (item is NotePageAction) {
      return item.label;
    }
    // Fallback to enum name
    return item.toString().split('.').last;
  }
  
  IconData _getIcon(T item) {
    // Handle different enum types
    if (item is NoteMenuAction) {
      return item.icon;
    } else if (item is CategoryMenuAction) {
      return item.icon;
    } else if (item is SortMenuAction) {
      return item.icon;
    } else if (item is EditorMenuAction) {
      return item.icon;
    } else if (item is NotePageAction) {
      return item.icon;
    }
    // Fallback icon
    return Icons.more_vert;
  }
}

/// Specialized popup menu for note actions
class NotePopupMenu extends StatelessWidget {
  const NotePopupMenu({
    super.key,
    required this.actions,
    required this.onSelected,
    this.enabled = true,
  });
  
  final List<NoteMenuAction> actions;
  final void Function(NoteMenuAction) onSelected;
  final bool enabled;
  
  @override
  Widget build(BuildContext context) {
    return AppPopupMenu<NoteMenuAction>(
      items: actions,
      onSelected: onSelected,
      enabled: enabled,
      icon: const Icon(Icons.more_vert),
    );
  }
}

/// Specialized popup menu for category actions
class CategoryPopupMenu extends StatelessWidget {
  const CategoryPopupMenu({
    super.key,
    required this.actions,
    required this.onSelected,
    this.enabled = true,
  });
  
  final List<CategoryMenuAction> actions;
  final void Function(CategoryMenuAction) onSelected;
  final bool enabled;
  
  @override
  Widget build(BuildContext context) {
    return AppPopupMenu<CategoryMenuAction>(
      items: actions,
      onSelected: onSelected,
      enabled: enabled,
      icon: const Icon(Icons.more_vert),
    );
  }
}

/// Specialized popup menu for sort actions
class SortPopupMenu extends StatelessWidget {
  const SortPopupMenu({
    super.key,
    required this.actions,
    required this.onSelected,
    this.enabled = true,
  });
  
  final List<SortMenuAction> actions;
  final void Function(SortMenuAction) onSelected;
  final bool enabled;
  
  @override
  Widget build(BuildContext context) {
    return AppPopupMenu<SortMenuAction>(
      items: actions,
      onSelected: onSelected,
      enabled: enabled,
      icon: const Icon(Icons.sort),
    );
  }
}

/// Specialized popup menu for editor actions
class EditorPopupMenu extends StatelessWidget {
  const EditorPopupMenu({
    super.key,
    required this.actions,
    required this.onSelected,
    this.enabled = true,
  });
  
  final List<EditorMenuAction> actions;
  final void Function(EditorMenuAction) onSelected;
  final bool enabled;
  
  @override
  Widget build(BuildContext context) {
    return AppPopupMenu<EditorMenuAction>(
      items: actions,
      onSelected: onSelected,
      enabled: enabled,
      icon: const Icon(Icons.more_vert),
    );
  }
}

/// Specialized popup menu for note page actions
class NotePagePopupMenu extends StatelessWidget {
  const NotePagePopupMenu({
    super.key,
    required this.actions,
    required this.onSelected,
    this.enabled = true,
  });
  
  final List<NotePageAction> actions;
  final void Function(NotePageAction) onSelected;
  final bool enabled;
  
  @override
  Widget build(BuildContext context) {
    return AppPopupMenu<NotePageAction>(
      items: actions,
      onSelected: onSelected,
      enabled: enabled,
      icon: const Icon(Icons.more_vert),
    );
  }
}