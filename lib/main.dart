import 'package:crudapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url:'https://aognpcafljqxlzvovadd.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFvZ25wY2FmbGpxeGx6dm92YWRkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc0ODE5MjgsImV4cCI6MjA1MzA1NzkyOH0.p9BSk0RtVvYPXIZmpVD5hIWeM0jZkjixwhv67GigNDk',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: appRoutes,
    );
  }
}
