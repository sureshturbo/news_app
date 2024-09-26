import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:task_news_app/models/news.dart';
import 'package:http/http.dart' as http;

class NewsProvider with ChangeNotifier{
    List<News> _newsList = [];
    List<News> _favoriteNews = [];
    //String apikey = '6d21f96ed9b74bf2bafe91bc7957f592';
    String apikey = 'a8b9dd1565294c94a6cbf91933d78990';

    List<News> get newsList => _newsList;

    List<News> get favoritelist => _favoriteNews;

    Future<void> fetchNews() async{
       // final url = 'https://newsapi.org/v2/everything?apiKey=$apikey';
        final url = 'https://newsapi.org/v2/everything?q=tesla&sortBy=publishedAt&apiKey=$apikey';
        print(url);
        try{
            final response = await http.get(Uri.parse(url));
            print(response.statusCode);
            print(response.body);
            if(response.statusCode == 200){
                    final jsonData = jsonDecode(response.body);
                    final List<dynamic> articles = jsonData['articles'];
                    _newsList = articles.map((articles)=> News.fromJson(articles)).toList();
                    notifyListeners();
            }else{
                throw Exception('Failed to load news');
            }
        }catch(e){
            throw e;
        }
    }

    void toggleFavorite(News news){
           if(_favoriteNews.contains(news)){
               _favoriteNews.remove(news);
           }else{
               _favoriteNews.add(news);
           }
           notifyListeners();
    }

    bool isFavorite(News news){
        return _favoriteNews.contains(news);
    }
}