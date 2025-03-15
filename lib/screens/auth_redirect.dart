// lib/widget/auth_redirect.dart
import 'package:coffee_house/providers/auth_state_provider.dart';
import 'package:coffee_house/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRedirect extends ConsumerWidget {
  final Widget child;

  const AuthRedirect({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    if (authState.needsLogin) {
      // Reset the flag to avoid infinite loop
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(authProvider.notifier).loginHandled();
        
        // Navigate to login
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
        );
      });
    }

    return child;
  }
}