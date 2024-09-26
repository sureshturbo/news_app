import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_news_app/provider/newsprovider.dart';
import 'package:task_news_app/screens/favorite_screen.dart';
import 'package:task_news_app/screens/news_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NewsProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme:ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context)=> NewsScreen(),
        '/favorite': (context)=> FavoriteScreen(),
      },
    );
  }
}

