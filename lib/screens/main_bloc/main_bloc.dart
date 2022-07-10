import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';
import 'package:neyex_home_assignment/global_vars.dart';
import 'package:neyex_home_assignment/repository/news_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/news_article.dart';


part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {

    on<LoadMainScreen>((event,emit) async{
      SharedPreferences sh = await SharedPreferences.getInstance();
      bool online = await isConnected();
      if(online){
        List<Article> articlesFirst = await NewsRepository().fetchArticles(
            GlobalVars.apiKey,
            'business',
            'us',
            '');
        List<Article> articlesSecond = await NewsRepository().fetchArticles(
            GlobalVars.apiKey,
            'business',
            'en',
            '');
        List<Article> articles = articlesFirst;
        articles.addAll(articlesSecond);
        articles.sort((a,b)=> a.publishedAt.compareTo(b.publishedAt));
        setLocalData(articles, sh);
        emit(MainLoaded(articles: articles));
      }
      else{
        List<Article> articles = await getLocalData(sh);
        emit(MainLoaded(articles: articles));
      }

    });


    on<MainScreenClean> ((event,emit) {
      if(state is  MainLoaded){
        final state= this.state as MainLoaded;
        emit(
          MainLoaded(articles: [])
        );
      }
    });


    on<MainScreenRefresh>((event,emit) async{
      print('[!] from event ');
      emit(MainInitial());
      add(LoadMainScreen());
    });
  }


  Future<void> setLocalData(List<Article> articles,SharedPreferences sh )async{
    List<Map<String,dynamic>> jsonList=[];
    print(articles.length);
    for(var article in articles){
      jsonList.add(article.toJson());
    }
    String jsonString = json.encode(jsonList);
    sh.setString('localData', jsonString);
  }

  Future<List<Article>> getLocalData(SharedPreferences sh)async{
    List<Article> result  = [];
    String jsonString = await sh.getString('localData' )?? '';
    if(jsonString==''){
      return [];
    }
    //print('[!] json string: '+jsonString);
    List<dynamic> jsonObject = jsonDecode(jsonString);
    print('[!] Json object length:'+ jsonObject.length.toString());
    for(var data in jsonObject){
      result.add(Article.fromJson(data));
    }
    return result;
  }

  Future<bool> isConnected()async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      return true;
    } else {
      return false;
    }
  }
}
