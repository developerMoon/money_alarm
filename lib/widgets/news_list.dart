import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:money_alarm/models/news_data.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsData>(
      builder: (context, newsData, child) {
//        if (newsData.newsCount == 0) {
//          return Center(child: CircularProgressIndicator());
//        }
        return ListView.builder(
          itemCount: newsData.newsCount,
          itemBuilder: (context, index) {
            String newsTitle = newsData.news.keys.elementAt(index);
            String newsUrl = newsData.news.values.elementAt(index);
            return ListTile(
              title: Text(newsTitle),
              onTap: () => _launchURL(newsUrl),
            );
          },
        );
      },
    );
//    else {
//      return Center(child: CircularProgressIndicator());
//    }
  }

  _launchURL(String newsUrl) async {
    if (await canLaunch(newsUrl)) {
      await launch(newsUrl);
    } else {
      throw 'Could not launch $newsUrl';
    }
  }
}
