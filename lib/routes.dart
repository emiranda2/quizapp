import 'package:crudapp/about/about.dart';
import 'package:crudapp/home/home.dart';
import 'package:crudapp/login/login.dart';
import 'package:crudapp/profile/profile.dart';
import 'package:crudapp/topics/topics.dart';

var appRoutes = {
  '/': (context) => HomeScreen(),
  '/login': (context) => LoginScreen(),
  '/profile': (context) => ProfileScreen(),
  '/about': (context) => AboutScreen(),
  '/topics': (context) => TopicsScreen(),
};