import 'package:flutter/material.dart';
import 'package:todoapp/screens/homeScreen/home_screen.dart';

void main() {
  runApp(MaterialApp(
    title: "Todo List",
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    debugShowCheckedModeBanner: false,
    home: const HomeScreen(),
  ));
}
