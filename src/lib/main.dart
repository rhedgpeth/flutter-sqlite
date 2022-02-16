import 'package:flutter/material.dart';
import 'package:rolodex/home_page.dart';
import 'data/database_helper.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rolodex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor:  const Color(0xFF02BB9F),
        primaryColorDark: const Color(0xFF167F67)
      ),
      home: const HomePage(title: 'Rolodex')
    );
  }
}