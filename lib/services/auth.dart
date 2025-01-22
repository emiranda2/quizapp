import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Stream<AuthState> get userStream => _supabase.auth.onAuthStateChange;

  User? get user => _supabase.auth.currentUser;
}