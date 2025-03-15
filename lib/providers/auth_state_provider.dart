// lib/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final bool isAuthenticated;
  final bool needsLogin;
  
  AuthState({this.isAuthenticated = false, this.needsLogin = false});
  
  AuthState copyWith({bool? isAuthenticated, bool? needsLogin}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      needsLogin: needsLogin ?? this.needsLogin,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());
  
  void setAuthenticated(bool value) {
    state = state.copyWith(isAuthenticated: value);
  }
  
  void requireLogin() {
    state = state.copyWith(needsLogin: true);
  }
  
  void loginHandled() {
    state = state.copyWith(needsLogin: false);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());