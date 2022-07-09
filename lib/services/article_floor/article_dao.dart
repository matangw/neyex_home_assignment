
import 'package:floor/floor.dart';
import 'package:neyex_home_assignment/models/news_article.dart';
import 'package:neyex_home_assignment/models/source_model.dart';

@dao
abstract class ArticleDao {
  @Query('SELECT * FROM Person')
  Future<List<Article>> findAllArticles();

  @Query('SELECT * FROM Person WHERE id = :id')
  Stream<Article?> findPersonById(Source source);

  @insert
  Future<void> insertArticle(Article article);
}