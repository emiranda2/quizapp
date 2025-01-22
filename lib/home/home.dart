import 'package:crudapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:crudapp/login/login.dart';
import 'package:crudapp/topics/topics.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else if (snapshot.hasData && snapshot.data!.session != null) {
          // Check if the session (user) exists
          return const TopicsScreen();
        } else {
          // User is not signed in
          return const LoginScreen();
        }
      },
    );
  }
}
