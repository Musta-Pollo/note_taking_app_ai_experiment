import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/app/router/app_router.dart';
import 'package:note_taking_app/core/theme/context_extension.dart';
import 'package:note_taking_app/shared/constants/k.dart';

import 'login_mixins.dart';

@RoutePage()
class LoginPage extends ConsumerWidget with LoginState, LoginEvent {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FlutterLogin(
      title: K.appName,
      theme: LoginTheme(
        primaryColor: context.colorScheme.primary,
        accentColor: context.colorScheme.secondary,
        buttonTheme: LoginButtonTheme(
          backgroundColor: context.colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: K.borderRadius12),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(borderRadius: K.borderRadius16),
          elevation: K.elevation8,
        ),
      ),
      userValidator: validateEmail,
      navigateBackAfterRecovery: true,
      passwordValidator: validatePassword,
      onLogin: (loginData) => signIn(ref, loginData),
      onSignup: (signupData) => signUp(ref, signupData),
      onRecoverPassword: (email) => recoverPassword(ref, email),
      onSubmitAnimationCompleted: () {
        // Navigate to home page after successful login
        context.navigateTo(const HomeRoute());
      },
    );
  }
}
