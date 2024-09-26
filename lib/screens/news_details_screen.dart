
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/news.dart';
import '../provider/newsprovider.dart';

class NewsDetailScreen extends StatelessWidget {
  final News news;

  NewsDetailScreen({required this.news});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title, style: TextStyle(fontSize: 16)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              news.imageUrl.isNotEmpty ?
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                        news.imageUrl,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            shape: BoxShape.circle
                        ),
                        child: Icon(
                          newsProvider.isFavorite(news) ? Icons.favorite : Icons.favorite_border,
                          color: newsProvider.isFavorite(news) ? Colors.red : Colors.grey,
                        ),
                      )),
                ],
              )
                  : Container(
                height: 200,
                color: Colors.grey,
                child: Center(
                    child: Icon(Icons.image, color: Colors.white, size: 50)),
              ),
              SizedBox(height: 16),
              Text(
                news.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ///
              Text(
                'Published At: ${news.date}',
                style: TextStyle(color: Colors.grey),
              ),
              ///
              SizedBox(height: 16),
              Text(
                news.description,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                news.description ?? "No additional content available",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

