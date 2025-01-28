import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      // Attempt to sign out the current user from Supabase
      await _supabase.auth.signOut();
      print('Sign-out successful');

      // Attempt to sign out from Google
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      print('Google sign-out successful');
    } catch (e) {
      // Handle any unexpected errors
      print('Error during sign-out: $e');
    }
  }

  Future<void> googleLogin() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['openid', 'email'],
      );
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        print('Google sign-in aborted');
        return;
      }

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;
      print('Google Authentication token penis: $accessToken');  // Log googleAuth
      print('This is the idToken $idToken');

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      final response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (response.user == null || response.session == null) {
        throw Exception('Error during Google sign-in: No session or user found.');
      }

      print('Google sign-in successful');
    } on AuthException catch (e) {
      // Handle authentication-specific errors
      print('Error during Google sign-in: ${e.message}');
    } catch (e) {
      // Handle any other unexpected errors
      print('Unexpected error: ${e}');
    }
  }
}