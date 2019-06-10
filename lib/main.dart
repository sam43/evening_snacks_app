import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/app.dart';
import 'src/screens/landing_screen.dart';

/*void main() => runApp(App());*/

Future<void> main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool check = prefs.getBool('logged_in');
  runApp(check == true ? MyApp() : App());
}