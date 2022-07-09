import 'dart:convert';
import 'package:floor/floor.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:neyex_home_assignment/models/source_model.dart';
part 'news_article.g.dart';

@JsonSerializable (explicitToJson :  true )
@entity
class Article extends Equatable{
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
  Article(
      { required this.source,
        required this.author,
        required this.title,
        required this.description,
        required this.url,
        required this.urlToImage,
        required this.publishedAt,
        required this.content});
/*
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String,
      publishedAt: json['publishedAt'] as String,
      content: json['content'] as String,
    );
  }*/

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);


  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  @override
  String toString() => json.encode(toJson());

  @override
    List<Object> get props => [source,author,title,description,url,urlToImage,publishedAt,content];
}