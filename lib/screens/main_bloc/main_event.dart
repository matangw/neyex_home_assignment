part of 'main_bloc.dart';

@immutable
abstract class MainEvent extends Equatable{
    const MainEvent();

    @override
    List<Object> get props => [];
}

class LoadMainScreen extends MainEvent{}


class MainScreenRefresh extends MainEvent{
    MainScreenRefresh(){
        print('[!] EVENT EMITTED' );
    }

    @override
    List<Object> get props => [];
}


class MainScreenClean extends MainEvent{
    final List<Article> articlesFirst =[];
    final List<Article> articlesSecond =[];

    MainScreenClean ();

    @override
    List<Object> get props => [articlesFirst,articlesSecond];
}
