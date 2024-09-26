

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_news_app/provider/newsprovider.dart';

import 'news_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Favorites'),),
      body:
      newsProvider.favoritelist.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: newsProvider.favoritelist.length,
        itemBuilder: (context, index) {
          final news =  newsProvider.favoritelist[index];
          return NewsCard(news: news);
        },
      )
      ///
    );
  }
}
