part of 'main_bloc.dart';

@immutable
abstract class MainState  extends Equatable{
  const MainState();

  @override
  List<Object> get props => [];
}

class MainInitial extends MainState {}

class MainLoaded extends MainState{
  final List<Article> articlesFirst;
  final List<Article> articlesSecond;

  const MainLoaded({required this.articlesFirst,required this.articlesSecond});
  @override
  List<Object> get props => [articlesFirst,articlesSecond];
}
