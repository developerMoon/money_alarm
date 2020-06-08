import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:money_alarm/models/news_data.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsData>(
      builder: (context, newsData, child) {
//        if (newsData.newsCount == 0) {
//          return Center(child: CircularProgressIndicator());
//        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(newsData.news[index]),
            );
          },
          itemCount: newsData.newsCount,
        );
      },
    );
//    else {
//      return Center(child: CircularProgressIndicator());
//    }
  }
}
