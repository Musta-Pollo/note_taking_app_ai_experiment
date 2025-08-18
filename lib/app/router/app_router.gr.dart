// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [CategoryPage]
class CategoryRoute extends PageRouteInfo<CategoryRouteArgs> {
  CategoryRoute({
    Key? key,
    required String categoryId,
    List<PageRouteInfo>? children,
  }) : super(
          CategoryRoute.name,
          args: CategoryRouteArgs(key: key, categoryId: categoryId),
          initialChildren: children,
        );

  static const String name = 'CategoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CategoryRouteArgs>();
      return CategoryPage(key: args.key, categoryId: args.categoryId);
    },
  );
}

class CategoryRouteArgs {
  const CategoryRouteArgs({this.key, required this.categoryId});

  final Key? key;

  final String categoryId;

  @override
  String toString() {
    return 'CategoryRouteArgs{key: $key, categoryId: $categoryId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CategoryRouteArgs) return false;
    return key == other.key && categoryId == other.categoryId;
  }

  @override
  int get hashCode => key.hashCode ^ categoryId.hashCode;
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [NotFoundPage]
class NotFoundRoute extends PageRouteInfo<void> {
  const NotFoundRoute({List<PageRouteInfo>? children})
      : super(NotFoundRoute.name, initialChildren: children);

  static const String name = 'NotFoundRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NotFoundPage();
    },
  );
}

/// generated route for
/// [NoteEditorPage]
class NoteEditorRoute extends PageRouteInfo<NoteEditorRouteArgs> {
  NoteEditorRoute({
    Key? key,
    required String noteId,
    List<PageRouteInfo>? children,
  }) : super(
          NoteEditorRoute.name,
          args: NoteEditorRouteArgs(key: key, noteId: noteId),
          rawPathParams: {'noteId': noteId},
          initialChildren: children,
        );

  static const String name = 'NoteEditorRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<NoteEditorRouteArgs>(
        orElse: () =>
            NoteEditorRouteArgs(noteId: pathParams.getString('noteId')),
      );
      return NoteEditorPage(key: args.key, noteId: args.noteId);
    },
  );
}

class NoteEditorRouteArgs {
  const NoteEditorRouteArgs({this.key, required this.noteId});

  final Key? key;

  final String noteId;

  @override
  String toString() {
    return 'NoteEditorRouteArgs{key: $key, noteId: $noteId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NoteEditorRouteArgs) return false;
    return key == other.key && noteId == other.noteId;
  }

  @override
  int get hashCode => key.hashCode ^ noteId.hashCode;
}

/// generated route for
/// [NotePage]
class NoteRoute extends PageRouteInfo<NoteRouteArgs> {
  NoteRoute({Key? key, required NoteEntity note, List<PageRouteInfo>? children})
      : super(
          NoteRoute.name,
          args: NoteRouteArgs(key: key, note: note),
          initialChildren: children,
        );

  static const String name = 'NoteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NoteRouteArgs>();
      return NotePage(key: args.key, note: args.note);
    },
  );
}

class NoteRouteArgs {
  const NoteRouteArgs({this.key, required this.note});

  final Key? key;

  final NoteEntity note;

  @override
  String toString() {
    return 'NoteRouteArgs{key: $key, note: $note}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NoteRouteArgs) return false;
    return key == other.key && note == other.note;
  }

  @override
  int get hashCode => key.hashCode ^ note.hashCode;
}

/// generated route for
/// [SearchPage]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute({List<PageRouteInfo>? children})
      : super(SearchRoute.name, initialChildren: children);

  static const String name = 'SearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SearchPage();
    },
  );
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsPage();
    },
  );
}
