import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:neyex_home_assignment/models/news_article.dart';
import 'package:retrofit/retrofit.dart';


part 'newsClient.g.dart';

@RestApi (baseUrl :  "https://newsapi.org/" )
abstract  class  NewsClient {
  factory  NewsClient ( Dio dio, { String baseUrl}) =  _NewsClient ;

  @GET("v2/top-headlines")
  Future<List<Article>> fetchItems(
    @Query("apikey") String apiKey,
    @Query("category") String category,
    @Query("country") String country,
    @Query("q") String q,
  );


}

