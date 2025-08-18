# Flutter Code Review Guide for AI Agent

## Core Review Principles

### 1. Clean Architecture Verification

**Check for proper layer separation:**

- **Presentation Layer**: UI widgets, state management (Riverpod providers)
- **Domain Layer**: Business logic, use cases, abstract repositories
- **Data Layer**: Concrete implementations, API services, database access

**Dependency Rule**: Dependencies must flow inward (outer layers depend on inner layers, never reverse)

### 2. SOLID Principles Checklist

- **Single Responsibility**: Each class/widget should have one reason to change
- **Open/Closed**: Code should be extensible without modification
- **Liskov Substitution**: Subclasses must be replaceable for base classes
- **Interface Segregation**: Small, specific interfaces over large ones
- **Dependency Inversion**: Depend on abstractions, not concrete implementations

## Technical Review Points

### State Management (Riverpod)

✅ **Good Practices:**

- Providers as top-level final variables
- Using appropriate provider types (StateProvider for simple state, StateNotifierProvider for complex logic)
- No side effects in provider initialization
- Using `autoDispose` for temporary data
- Context-independent state management

❌ **Anti-patterns:**

- Initializing providers in widgets
- Using providers for ephemeral UI state
- Dynamic provider creation
- Performing side effects during initialization

### Database (Drift)

✅ **Check for:**

- Type-safe queries
- Proper migration strategy with version management
- Repository pattern implementation
- Abstraction behind interfaces

### Navigation (AutoRoute)

✅ **Verify:**

- Type-safe arguments
- Centralized router configuration
- Proper use of route guards for access control
- @RoutePage annotations on routable widgets

### Widget Structure

✅ **Best Practices:**

- Small, focused widgets (preferably const)
- Proper decomposition (StatelessWidget vs StatefulWidget)
- Localized setState() calls to smallest subtree
- Reusable components extracted
- No business logic in widgets

❌ **Avoid:**

- Large, monolithic widgets
- Business logic mixed with UI
- Excessive widget nesting
- Missing const constructors where applicable

## Code Quality Markers

### Project Structure

```
lib/
├── core/           # App-wide utilities, constants, routing
├── data/           # Repositories, models, data sources
├── domain/         # Entities, use cases, abstract repositories
├── presentation/   # UI widgets, screens, view models
└── utils/          # Helper functions, extensions
```

### Helper Methods & DRY

- Each helper method should have single responsibility
- Clear, descriptive naming
- Generic and reusable design
- Proper placement (core/utils for app-wide, feature-specific for localized)

## Performance Checks

1. **Widget Optimization**:

   - Using const constructors where possible
   - Minimizing rebuilds with proper state management
   - Using .select() for targeted state listening

2. **Database**:

   - Efficient query design
   - Proper indexing
   - Migration performance considerations

3. **Navigation**:
   - Lazy loading of routes
   - Proper disposal of resources

## Testing Considerations

✅ **Verify testability**:

- Mockable dependencies through interfaces
- Pure functions where possible
- Isolated business logic
- Provider overrides for testing
- No direct database/API calls in domain layer

## Red Flags to Identify

1. **Architecture Violations**:

   - Domain layer importing from data/presentation
   - Direct database access in widgets
   - Business logic in UI components

2. **State Management Issues**:

   - setState() in large widget trees
   - Global variables for state
   - Uncontrolled side effects

3. **Code Smells**:
   - Duplicate code across features
   - God classes/widgets
   - Magic numbers without constants
   - Missing error handling
   - Hardcoded values that should be configurable

## Review Response Template

When reviewing, structure feedback as:

1. **Critical Issues** (Must fix):

   - Architecture violations
   - Security vulnerabilities
   - Performance bottlenecks

2. **Important Improvements** (Should fix):

   - SOLID principle violations
   - Missing error handling
   - Code duplication

3. **Suggestions** (Consider):
   - Better naming conventions
   - Additional decomposition opportunities
   - Performance optimizations

## Quick Decision Framework

For each code element, ask:

1. Does it follow the dependency rule?
2. Is it testable in isolation?
3. Does it have a single, clear responsibility?
4. Is it properly abstracted from external dependencies?
5. Would changes to requirements require minimal code modification?

## Common Patterns to Recommend

- **Repository Pattern**: For data access abstraction
- **Use Cases**: For business logic encapsulation
- **Factory Pattern**: For complex object creation
- **Builder Pattern**: For complex widget configuration
- **Observer Pattern**: Via Riverpod for reactive updates

## Tools & Automation

Recommend using:

- `build_runner` for code generation
- `flutter_lints` for consistent code style
- `freezed` for immutable models
- `riverpod` for dependency injection
- Git hooks for pre-commit checks

--

# Flutter Clean Architecture: A Practical Guide

## Executive Summary

This guide provides practical advice for building scalable Flutter applications using Clean Architecture, modern state management, and industry best practices. By following these patterns, you'll create apps that are easier to test, maintain, and scale.

## 1. Clean Architecture Fundamentals

### What is Clean Architecture?

Clean Architecture separates your app into distinct layers, each with specific responsibilities. This separation makes your code more modular, testable, and maintainable.

**Key Principle**: Dependencies flow inward. Inner layers never depend on outer layers.

### The Three Layers

#### 1. **Presentation Layer** (Outermost)

- **What it does**: Handles UI and user interactions
- **Contains**:
  - Widgets (screens, UI components)
  - State management (Riverpod providers)
- **Rule**: Keep UI logic minimal - just display data and handle user input

#### 2. **Domain Layer** (Middle)

- **What it does**: Contains business logic
- **Contains**:
  - Use Cases (business rules)
  - Entities (core business objects)
  - Repository interfaces (contracts for data access)
- **Rule**: No framework dependencies - pure Dart code only

#### 3. **Data Layer** (Inner)

- **What it does**: Handles data operations
- **Contains**:
  - Repository implementations
  - Data sources (APIs, databases)
  - Data models
- **Rule**: Implements the contracts defined in Domain layer

### Project Structure

```
lib/
├── core/           # App-wide utilities
│   ├── constants/
│   ├── routes/
│   └── theme/
├── data/           # Data layer
│   ├── models/
│   ├── repositories/
│   └── services/
├── domain/         # Business logic
│   ├── entities/
│   ├── repositories/
│   └── use_cases/
└── presentation/   # UI layer
    ├── screens/
    ├── widgets/
    └── providers/
```

## 2. State Management with Riverpod

### Why Riverpod?

- **No BuildContext required**: Test business logic without UI
- **Compile-time safety**: Catches errors during development
- **Built-in dependency injection**: No need for additional DI packages
- **Better testability**: Easy to mock and override providers

### Core Concepts

#### Provider Types

| Provider Type             | Use Case             | Example                       |
| ------------------------- | -------------------- | ----------------------------- |
| **Provider**              | Inject dependencies  | API clients, repositories     |
| **StateProvider**         | Simple mutable state | Toggles, counters             |
| **StateNotifierProvider** | Complex state logic  | User profiles, shopping carts |
| **FutureProvider**        | Async operations     | API calls, database queries   |
| **StreamProvider**        | Real-time data       | Chat messages, live updates   |

#### Basic Example

```dart
// Define a provider
final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier(ref.read(userRepositoryProvider));
});

// Use in a widget
class UserProfile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Text(user.name);
  }
}
```

### Best Practices

✅ **DO**:

- Use `autoDispose` for temporary data
- Initialize providers at the top level
- Use `.select()` to optimize rebuilds

❌ **DON'T**:

- Initialize providers in widgets
- Use providers for local widget state
- Perform side effects during initialization

## 3. Local Database with Drift

### Why Drift?

- **Type-safe queries**: Compile-time validation
- **Reactive**: Queries return streams that auto-update
- **Powerful**: Supports complex SQL operations
- **Code generation**: Reduces boilerplate

### Basic Setup

```dart
// 1. Define your table
class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
}

// 2. Create database class
@DriftDatabase(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  @override
  int get schemaVersion => 1;
}
```

### Integration with Repository Pattern

```dart
// Domain layer - abstract interface
abstract class TaskRepository {
  Stream<List<Task>> watchAllTasks();
  Future<void> addTask(Task task);
}

// Data layer - concrete implementation
class TaskRepositoryImpl implements TaskRepository {
  final AppDatabase _db;

  @override
  Stream<List<Task>> watchAllTasks() {
    return _db.select(_db.tasks).watch();
  }
}
```

## 4. Widget Best Practices

### Widget Decomposition

**Rule**: Break large widgets into smaller, focused components

**Benefits**:

- Better performance (Flutter can optimize const widgets)
- Easier to test and maintain
- More reusable

### Example: Before and After

```dart
// ❌ Bad: Everything in one widget
class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header code...
          // Product list code...
          // Footer code...
        ],
      ),
    );
  }
}

// ✅ Good: Decomposed into smaller widgets
class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ProductHeader(),
          Expanded(child: ProductList()),
          const ProductFooter(),
        ],
      ),
    );
  }
}
```

### Performance Tips

1. **Use const constructors** wherever possible
2. **Localize setState()** to the smallest widget subtree
3. **Extract reusable widgets** to avoid duplication
4. **Use Keys** in dynamic lists to preserve state

## 5. Navigation with AutoRoute

### Why AutoRoute?

- **Type-safe arguments**: No more passing wrong data types
- **Code generation**: Reduces boilerplate
- **Nested navigation**: Independent navigation stacks
- **Route guards**: Built-in access control

### Basic Setup

```dart
// 1. Annotate your pages
@RoutePage()
class HomePage extends StatelessWidget {
  // ...
}

// 2. Define your router
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: ProfileRoute.page, guards: [AuthGuard()]),
  ];
}

// 3. Navigate with type safety
context.router.push(ProfileRoute(userId: 123));
```

## 6. Helper Methods and Utilities

### When to Create Helper Methods

Create helper methods for:

- Repeated calculations
- Date/time formatting
- Input validation
- API response parsing

### Organization

```
lib/
└── utils/
    ├── validators.dart    # Input validation
    ├── formatters.dart    # Date, currency formatting
    ├── extensions.dart    # Dart extensions
    └── constants.dart     # App-wide constants
```

### Example Helper Method

```dart
// utils/validators.dart
class Validators {
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static String? validatePassword(String? value) {
    if (value == null || value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }
}
```

## 7. Key Takeaways

### The Synergy Effect

These practices work best together:

- **Clean Architecture** provides the structure
- **Riverpod** connects the layers
- **Drift** manages local data
- **AutoRoute** handles navigation
- **Widget decomposition** optimizes UI
- **Helper methods** reduce duplication

### Start Simple, Grow Smart

1. **For small projects**: Focus on widget decomposition and basic state management
2. **For medium projects**: Add Clean Architecture layers and Riverpod
3. **For large projects**: Implement all practices with strict adherence

### Continuous Improvement

- **Refactor regularly**: Keep code clean as requirements change
- **Be pragmatic**: Don't over-engineer small apps
- **Document well**: Help future developers (including yourself)
- **Test thoroughly**: Each layer should be independently testable

## Quick Reference Checklist

### Setting Up a New Feature

- [ ] Define domain entities and use cases
- [ ] Create repository interface in domain layer
- [ ] Implement repository in data layer
- [ ] Set up Riverpod providers for state management
- [ ] Build UI widgets (keep them small and focused)
- [ ] Add routes to AutoRoute configuration
- [ ] Write unit tests for each layer
- [ ] Document complex business logic

### Code Quality Checks

- [ ] Dependencies flow inward only
- [ ] No business logic in widgets
- [ ] All providers are top-level finals
- [ ] Widgets use const where possible
- [ ] Helper methods follow single responsibility
- [ ] Navigation uses type-safe arguments
- [ ] Database queries are reactive (streams)

## Conclusion

Building quality Flutter applications is about making smart architectural choices early and maintaining discipline as your project grows. These patterns aren't just theoretical - they solve real problems:

- **Testing becomes easier** when layers are independent
- **New features integrate smoothly** with clear boundaries
- **Teams collaborate better** with consistent patterns
- **Performance improves** through optimized widgets
- **Maintenance costs decrease** with organized code

Start with what makes sense for your project size, but always build with growth in mind. The investment in proper architecture pays dividends as your application evolves.
