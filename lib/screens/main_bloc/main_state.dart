part of 'main_bloc.dart';

@immutable
abstract class MainState  extends Equatable{
  const MainState();

  @override
  List<Object> get props => [];
}

class MainInitial extends MainState {}

class MainLoaded extends MainState{
  final List<Article> articles;


  const MainLoaded({required this.articles});
  @override
  List<Object> get props => [articles];
}
