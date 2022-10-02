import 'package:flutter/material.dart';
import 'package:flutter_with_laravel/screens/loading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter with Laravel',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const LoadingScreen(),
    );
  }
}
