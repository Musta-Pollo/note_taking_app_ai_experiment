import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Unified constants class following K.* pattern for easy access
/// Replaces all hardcoded values with semantic constants
class K {
  const K._(); // Private constructor

  // ============================================================================
  // SPACING & DIMENSIONS
  // ============================================================================
  
  // Spacing values
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;
  static const double spacing48 = 48.0;
  static const double spacing64 = 64.0;
  static const double spacing80 = 80.0;
  static const double spacing96 = 96.0;

  // Gap widgets for consistent spacing
  static const Gap gap4 = Gap(spacing4);
  static const Gap gap8 = Gap(spacing8);
  static const Gap gap12 = Gap(spacing12);
  static const Gap gap16 = Gap(spacing16);
  static const Gap gap20 = Gap(spacing20);
  static const Gap gap24 = Gap(spacing24);
  static const Gap gap32 = Gap(spacing32);
  static const Gap gap40 = Gap(spacing40);
  static const Gap gap48 = Gap(spacing48);
  static const Gap gap64 = Gap(spacing64);
  static const Gap gap80 = Gap(spacing80);
  static const Gap gap96 = Gap(spacing96);

  // ============================================================================
  // BORDER RADIUS
  // ============================================================================
  
  static const double cornerRadius4 = 4.0;
  static const double cornerRadius8 = 8.0;
  static const double cornerRadius12 = 12.0;
  static const double cornerRadius16 = 16.0;
  static const double cornerRadius20 = 20.0;
  static const double cornerRadius24 = 24.0;
  static const double cornerRadius32 = 32.0;

  // BorderRadius objects
  static const BorderRadius borderRadius4 = BorderRadius.all(Radius.circular(cornerRadius4));
  static const BorderRadius borderRadius8 = BorderRadius.all(Radius.circular(cornerRadius8));
  static const BorderRadius borderRadius12 = BorderRadius.all(Radius.circular(cornerRadius12));
  static const BorderRadius borderRadius16 = BorderRadius.all(Radius.circular(cornerRadius16));
  static const BorderRadius borderRadius20 = BorderRadius.all(Radius.circular(cornerRadius20));
  static const BorderRadius borderRadius24 = BorderRadius.all(Radius.circular(cornerRadius24));
  static const BorderRadius borderRadius32 = BorderRadius.all(Radius.circular(cornerRadius32));
  static const BorderRadius borderRadiusFull = BorderRadius.all(Radius.circular(9999));

  // ============================================================================
  // ICON SIZES
  // ============================================================================
  
  static const double iconSize16 = 16.0;
  static const double iconSize20 = 20.0;
  static const double iconSize24 = 24.0;
  static const double iconSize32 = 32.0;
  static const double iconSize48 = 48.0;
  static const double iconSize64 = 64.0;

  // ============================================================================
  // ELEVATION
  // ============================================================================
  
  static const double elevation0 = 0.0;
  static const double elevation1 = 1.0;
  static const double elevation2 = 2.0;
  static const double elevation4 = 4.0;
  static const double elevation8 = 8.0;
  static const double elevation16 = 16.0;

  // ============================================================================
  // OPACITY VALUES
  // ============================================================================
  
  static const double opacity10 = 0.1;
  static const double opacity20 = 0.2;
  static const double opacity30 = 0.3;
  static const double opacity50 = 0.5;
  static const double opacity70 = 0.7;
  static const double opacity80 = 0.8;
  static const double opacity90 = 0.9;

  // ============================================================================
  // DURATIONS
  // ============================================================================
  
  static const Duration duration100ms = Duration(milliseconds: 100);
  static const Duration duration200ms = Duration(milliseconds: 200);
  static const Duration duration300ms = Duration(milliseconds: 300);
  static const Duration duration500ms = Duration(milliseconds: 500);
  static const Duration duration1000ms = Duration(milliseconds: 1000);

  // Sync durations
  static const Duration syncDebounceDelay = Duration(milliseconds: 300);
  static const Duration syncTimeout = Duration(seconds: 10);
  static const Duration baseSyncRetryDelay = Duration(seconds: 1);

  // ============================================================================
  // STRINGS
  // ============================================================================
  
  // App info
  static const String appName = 'Notes App';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'A notes app with real-time sync';

  // Actions
  static const String add = 'Add';
  static const String edit = 'Edit';
  static const String delete = 'Delete';
  static const String cancel = 'Cancel';
  static const String save = 'Save';
  static const String done = 'Done';
  static const String close = 'Close';
  static const String ok = 'OK';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String share = 'Share';

  // Navigation
  static const String home = 'Home';
  static const String search = 'Search';
  static const String settings = 'Settings';
  static const String categories = 'Categories';
  static const String notes = 'Notes';
  static const String profile = 'Profile';

  // Auth
  static const String signIn = 'Sign In';
  static const String signUp = 'Sign Up';
  static const String signOut = 'Sign Out';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String verificationCode = 'Verification Code';
  static const String sendCode = 'Send Code';
  static const String verifyCode = 'Verify Code';
  
  // Auth labels and prompts
  static const String emailLabel = 'Email';
  static const String passwordLabel = 'Password';
  static const String signInLabel = 'Sign In';
  static const String signUpLabel = 'Sign Up';
  static const String signInPrompt = 'Already have an account? Sign In';
  static const String signUpPrompt = 'Don\'t have an account? Sign Up';

  // Messages
  static const String loading = 'Loading...';
  static const String noData = 'No data available';
  static const String tryAgain = 'Try again';
  static const String error = 'Error';
  static const String success = 'Success';
  static const String warning = 'Warning';
  static const String info = 'Info';

  // Notes
  static const String createNote = 'Create Note';
  static const String editNote = 'Edit Note';
  static const String deleteNote = 'Delete Note';
  static const String noteCreated = 'Note created successfully';
  static const String noteUpdated = 'Note updated successfully';
  static const String noteDeleted = 'Note deleted successfully';
  static const String untitledNote = 'Untitled Note';
  static const String recentNotes = 'Recent Notes';
  static const String allNotes = 'All Notes';
  static const String noNotesYet = 'No notes yet';
  static const String noNotesInCategory = 'No notes in this category';

  // Categories
  static const String createCategory = 'Create Category';
  static const String editCategory = 'Edit Category';
  static const String deleteCategory = 'Delete Category';
  static const String categoryCreated = 'Category created successfully';
  static const String categoryUpdated = 'Category updated successfully';
  static const String categoryDeleted = 'Category deleted successfully';
  static const String allCategories = 'All Categories';
  static const String noCategoriesYet = 'No categories yet';

  // Search
  static const String searchNotes = 'Search notes...';
  static const String searchResults = 'Search Results';
  static const String noResultsFound = 'No results found';
  static const String searchTips = 'Search tips: Use keywords to find notes quickly';

  // Sync
  static const String syncing = 'Syncing...';
  static const String syncComplete = 'Sync complete';
  static const String syncFailed = 'Sync failed';
  static const String offline = 'Offline';
  static const String online = 'Online';

  // Validation messages
  static const String fieldRequired = 'This field is required';
  static const String emailRequired = 'Email is required';
  static const String emailInvalid = 'Please enter a valid email';
  static const String passwordRequired = 'Password is required';
  static const String passwordTooShort = 'Password must be at least 6 characters';
  static const String passwordsDoNotMatch = 'Passwords do not match';
  
  // Validation message constants (for backwards compatibility)
  static const String emailRequiredMessage = emailRequired;
  static const String emailInvalidMessage = emailInvalid;
  static const String passwordRequiredMessage = passwordRequired;
  static const String passwordTooShortMessage = passwordTooShort;

  // Error messages
  static const String genericErrorMessage = 'Something went wrong. Please try again.';
  static const String networkErrorMessage = 'Network error. Please check your connection and try again.';
  static const String syncErrorMessage = 'Sync failed. Your changes will be saved locally and synced when connection is restored.';

  // Confirmation messages
  static const String deleteNoteMessage = 'Are you sure you want to delete this note? This action cannot be undone.';
  static const String deleteCategoryMessage = 'Are you sure you want to delete this category? All notes in this category will also be deleted.';
  static const String signOutMessage = 'Are you sure you want to sign out?';

  // Emojis
  static const String fullNoteEmoji = '✏️';
  static const String simpleNoteEmoji = '📝';
  static const String categoryEmoji = '📁';

  // ============================================================================
  // NUMERIC CONSTANTS
  // ============================================================================
  
  static const int noteContentPreviewLength = 100;
  static const int passwordMinLength = 6;
  static const int maxSyncRetries = 3;
  static const int recentNotesLimit = 5;
  static const int searchDebounceMs = 300;
  
  // ============================================================================
  // SPECIAL CONSTANTS
  // ============================================================================
  
  static const String offlineUserId = 'offline-user';
  static const String lastPulledAtKey = 'lastPulledAt';
}