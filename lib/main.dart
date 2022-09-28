import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/quotes.dart';
import 'package:todo_app/screens/homescreen.dart';
import 'package:todo_app/screens/quotedetails.dart';

void main() {
  runApp(
    MultiProvider(providers: [
   ChangeNotifierProvider(
    create: (_) => Quotes()
    ),
    
    //  ChangeNotifierProvider(
    // create: (_) => QuoteItem()
    // ),
    
    ],  child: const MyApp(),)
   );
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
      routes: {
        QuoteDetails.routeName:(_)=>QuoteDetails()
      },
    );
  }
}
