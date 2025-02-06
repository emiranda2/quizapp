import 'package:crudapp/services/services.dart';
import 'package:crudapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var report = Provider.of<Report>(context);
    var user = AuthService().user;
    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Colors.deepOrange,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  child: Image.asset(
                    'assets/user.png',
                    fit: BoxFit.contain,
                    height: 100,
                    width: 100,
                    ),
                ),
              Column(
                children: [
                  Text(
                    '${report.total}',
                    style: TextStyle(
                      fontSize: 80,)
                    ),
                  Text(
                    'Quizzes Completed',
                    style:TextStyle(
                      fontSize: 15,)
                    ),
                ],
              ),
              ElevatedButton(
                  onPressed: () async {
                    await AuthService().signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  child: Text('Signout')),
            ],
          ),
        ),
      );
    } else {
      return const LoadingScreen();
    }
  }
}
