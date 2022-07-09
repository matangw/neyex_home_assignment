// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:neyex_home_assignment/services/article_floor/article_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../models/news_article.dart';


part 'article_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Article])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}