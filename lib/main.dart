import 'package:flutter/material.dart';
import 'package:movie_app_2/screens/home_screen.dart';
import 'package:movie_app_2/services/api_service.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
