// lib/features/auth/providers/auth_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ease_my_health/features/auth/providers/auth_state.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() => const AuthState();

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      // Add your authentication logic here
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        userId: 'user123',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> signUp(String email, String password, String name, String phone) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      // Add your signup logic here
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        userId: 'user123',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void signOut() {
    state = const AuthState();
  }
}