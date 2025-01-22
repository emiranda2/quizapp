import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Stream<AuthState> get userStream => _supabase.auth.onAuthStateChange;

  User? get user => _supabase.auth.currentUser;

  Future<void> anonLogin() async {
    try {
      // Attempt to sign in anonymously using Supabase
      await Supabase.instance.client.auth.signInAnonymously();
      print('Anonymous sign-in successful');
    } on AuthException catch (e) {
      // Handle authentication-specific errors
      print('Error during anonymous sign-in: ${e.message}');
    } catch (e) {
      // Handle any other unexpected errors
      print('Unexpected error: $e');
    }
  }

  Future<void> signOut() async {
    try {
      // Attempt to sign out the current user
      await _supabase.auth.signOut();
      print('Sign-out successful');
    } catch (e) {
      // Handle any unexpected errors
      print('Error during sign-out: $e');
    }
  }
}