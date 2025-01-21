import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Notes'),
      ),
      body: Container(),
          floatingActionButton: FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: ((context) {
            return SimpleDialog(
              title: const Text('Add a Note'),
              contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
              children: [
                TextFormField(
                  onFieldSubmitted: (value) async {
                    await Supabase.instance.client
                        .from('notes')
                        .insert({'body': value});
                  },
                ),
              ],
            );
          }),
        );
      },
      child: const Icon(Icons.add),
    ),
    );
  }
}