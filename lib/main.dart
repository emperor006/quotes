import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/quotes.dart';
import 'package:todo_app/screens/homescreen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => Quotes(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
