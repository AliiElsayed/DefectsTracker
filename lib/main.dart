import 'package:defects_tracker/constants.dart';
import 'package:defects_tracker/screens/add_screen.dart';
import 'package:defects_tracker/screens/details_screen.dart';
import 'package:defects_tracker/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'defects Tracker',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/DetailsScreen': (context) => DetailsScreen(),
        '/AddScreen': (context) => AddScreen(),
      },
      theme: ThemeData(
        fontFamily: 'Source Sans Pro',
        primarySwatch: kPrimaryColor,
          //Color(0xff025566)
      ),
    );
  }
}
