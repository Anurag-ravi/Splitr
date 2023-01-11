// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitr/pages/homepage.dart';
import 'package:splitr/pages/signuppage.dart';
late SharedPreferences prefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splitr',
      theme: ThemeData(
            fontFamily: 'Poppins',
            brightness: Brightness.light,
            primarySwatch: Colors.grey,
            primaryColor: Colors.black,
            colorScheme: ColorScheme.light(
              primary: Color.fromARGB(255, 255, 200, 48),
              secondary: Colors.black,
              background: Color(0xfffafafa),
              error: Colors.red,
            ),
            dividerColor: Colors.black12,
            iconTheme: IconThemeData(color: Colors.black)
          ),
          darkTheme: ThemeData(
            fontFamily: 'Poppins',
            brightness: Brightness.dark,
            primarySwatch: Colors.grey,
            primaryColor: Colors.white,
            colorScheme: ColorScheme.dark(
              primary: Color(0xffFFBA00),
              secondary: Colors.white,
              background: Color(0xff424242),
              error: Colors.red,
            ),
            dividerColor: Colors.black12,
            iconTheme: IconThemeData(color: Colors.white)
          ),
          themeMode: ThemeMode.light,
      home: prefs.getBool('login') == null ?  SignupPage() : HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
