import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_news_app/provider/newsprovider.dart';

import '../models/news.dart';
import 'favorite_screen.dart';
import 'news_details_screen.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NewsProvider>(context, listen: false).fetchNews();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: TabBar(
            indicatorColor: Colors.transparent,
            labelColor: Colors.red,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                icon: Icon(Icons.list),
                text: "News",
              ),
              Tab(
                icon: Icon(Icons.favorite),
                text: "Favs",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NewsListScreen(), // Display the news list here
            FavoriteScreen(), // Display the favorite news here
          ],
        ),
      ),
    );
  }
}



class NewsListScreen extends StatelessWidget {
  final List<News> newsList = [
    // News(
    //   title: "Purus suspendisse adipiscing quam.",
    //   description: "At leo tellus ornare adipiscing pharetra nisi ornare.",
    //   imageUrl: "https://via.placeholder.com/100", url: '', // Replace with actual image URL
    // //  date: "Mon, 21 Dec 2020 14:57 GMT",
    // ),
    // News(
    //   title: "Magnis in nisl.",
    //   description: "Suspendisse varius magna sed nibh.",
    //   imageUrl: "https://via.placeholder.com/100", url: '',
    // //  date: "Mon, 21 Dec 2020 14:57 GMT",
    // ),
    // Add more news items
  ];

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return
      newsProvider.newsList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: newsProvider.newsList.length,
        itemBuilder: (context, index) {
          final news =  newsProvider.newsList[index];
          return Dismissible(
            key: Key(news.title),
            direction: DismissDirection.endToStart,
            background: Container(
              padding: EdgeInsets.only(right: 16),
              color: Colors.red.shade100,
              alignment: Alignment.centerRight,
              child: Icon(
                newsProvider.isFavorite(news)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: newsProvider.isFavorite(news)
                    ? Colors.red
                    : Colors.grey,
              ),
            ),
            confirmDismiss: (direction) async{
              newsProvider.toggleFavorite(news);
              print("${news.title} marked as favorite");
              return false;
            },

            child: NewsCard(news: news),
          );
        },
      );

  }
}

class NewsCard extends StatelessWidget {
  final News news;

  const NewsCard({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewsDetailScreen(news: news),
                      ),);
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        margin:
        EdgeInsets.all(15),

        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child:
            // Image.network(
            //     news.imageUrl,
            //     width: 60,
            //     height: 60,
            //     fit: BoxFit.cover
            // ),
            news.imageUrl.isNotEmpty
                ? Image.network(
              news.imageUrl,
              width: 100,
              fit: BoxFit.cover,
            )
                : Container(
              width: 100,
              height: 100,
              color: Colors.grey,
              child: Icon(Icons.image, color: Colors.white),
            ),
          ),
          title: Text(
            news.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(news.description,maxLines: 3,),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(news.date.toString(), style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

