import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:neyex_home_assignment/global_vars.dart';
import 'package:neyex_home_assignment/repository/news_repository.dart';

import '../models/news_article.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {

    on<LoadMainScreen>((event,emit) async{
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
      emit(MainLoaded(articlesFirst: articlesFirst,articlesSecond: articlesSecond));
    });


    on<MainScreenClean> ((event,emit) {
      if(state is  MainLoaded){
        final state= this.state as MainLoaded;
        emit(
          MainLoaded(articlesFirst: [], articlesSecond: [])
        );
      }
    });


    on<MainScreenRefresh>((event,emit) async{
      print('[!] from event ');
      emit(MainInitial());
      add(LoadMainScreen());
    });
  }
}
