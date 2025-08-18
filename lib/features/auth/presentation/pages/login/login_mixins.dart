import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validation/form_validation.dart';
import 'package:note_taking_app/core/auth/auth_providers.dart';
import 'package:note_taking_app/shared/constants/k.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Login page state mixin - manages authentication state for LoginPage
mixin class LoginState {
  /// Get current authentication state
  AsyncValue<User?> authState(WidgetRef ref) => ref.watch(authUserProvider);
}

/// Login page events mixin - manages authentication actions for LoginPage
mixin class LoginEvent {
  /// Sign in with email and password
  Future<String?> signIn(WidgetRef ref, LoginData data) async {
    try {
      await ref.read(authServiceProvider.notifier).signIn(
            data.name,
            data.password,
          );
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  /// Sign up with email and password
  Future<String?> signUp(WidgetRef ref, SignupData data) async {
    try {
      await ref.read(authServiceProvider.notifier).signUp(
            data.name!,
            data.password!,
          );
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  /// Recover password with email
  Future<String?> recoverPassword(WidgetRef ref, String email) async {
    //TODO: Implement password recovery logic
    throw UnimplementedError(
      'Password recovery is not implemented yet',
    );
  }

  /// Validate email field using form_validation
  String? validateEmail(String? value) {
    final validator = Validator(
      validators: [
        const RequiredValidator(),
        const EmailValidator(),
      ],
    );

    return validator.validate(
      label: 'Email',
      value: value,
    );
  }

  /// Validate password field using form_validation
  String? validatePassword(String? value) {
    final validator = Validator(
      validators: [
        const RequiredValidator(),
        const MinLengthValidator(length: K.passwordMinLength),
      ],
    );

    return validator.validate(
      label: 'Password',
      value: value,
    );
  }
}
