import 'package:flutter/material.dart';
import 'package:tictac/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Game',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color.fromARGB(255, 2, 0, 31),
        shadowColor: const Color.fromARGB(231, 11, 0, 114),
        splashColor: const Color.fromARGB(233, 25, 0, 255),
      ),
      home: const HomePage(),
    );
  }
}
