import 'package:dio/dio.dart';

import '../screens/models/news_article.dart';
import '../services/newsClient.dart';

class NewsRepository {

  final NewsClient _client = NewsClient(Dio());

  NewsRepository();

  Future<List<Article>> fetchArticles(String apiKey, String category,String countryCode, String q) async {
    return await _client.fetchItems(apiKey, category, countryCode,q,)
        .then((value) => value)
        .catchError((e) {
      print(e);
      return [];
    });
  }
}