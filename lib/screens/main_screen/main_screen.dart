import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:neyex_home_assignment/screens/main_bloc/main_bloc.dart';
import 'package:neyex_home_assignment/models/news_article.dart';
import 'package:url_launcher/url_launcher.dart';
class MainScreenBlock extends StatefulWidget{



  @override
  State<MainScreenBlock> createState() => _MainScreenBlockState();
}

class _MainScreenBlockState extends State<MainScreenBlock> {


  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context)=> MainBloc()..add(LoadMainScreen()))
    ], child: Scaffold(
      appBar: AppBar(title: Text('NEYEX HOME ASSIGNMENT'),),
      body: Container(
        height: height,
        width: width,
        child: BlocBuilder<MainBloc,MainState>(
          builder: (context,state) {
            if(state is MainInitial){
              return Center(child: CircularProgressIndicator(color: Colors.blue,));
            }
            if(state is MainLoaded){
              return mainScreenContainer(height*0.8, width, state.articles,context);
            }
            else{
              return Container();
            }
          },
        )
      ),
    ) );
  }
  
  Widget mainScreenContainer(double height,double width,List<Article> articles,BuildContext context){
    return Container(
      height: height,
      width:  width,
      child: Column(
        children: [
          SizedBox(height: height*0.05,),
          Container(
            height: height*.1,
            width: width,
            child:  buttonsRow(height*0.1, width,context),
          ),
          Expanded(
            child: Container(
              width: width*0.95,
              child: articles.isNotEmpty?ListView.builder(
                itemCount: articles.length,
                  itemBuilder: (context,index){
                return newsContainer(height*0.25, width*0.95, articles[index]);
              })

              ///This only excuted when there is no connections and its the first app run
                  : Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       Icon(Icons.cancel,color: Colors.blue,size: height*0.2,),
                      SizedBox(height: height*0.05,),
                      Text('NO DATA',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                    ],
                  ))
            ),
          ),
        ],
      ),
    ) ;
  }

  Widget buttonsRow(double height,double width,BuildContext context){
    return Container(
      height: height,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          button(height, width*0.4, Icons.refresh, 'REFRESH',
                  () {context.read<MainBloc>().add(MainScreenRefresh());},context),
          button(height, width*0.4, Icons.clear, 'Clear',
                  () {context.read<MainBloc>().add(MainScreenClean());} ,context)
        ],
      ),
    );
  }

  Widget button(double height,double width, IconData icon,String text,Function() function,BuildContext context){
   return InkWell(
     onTap: function,
     child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(height*0.2),color: Colors.blue),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon,color: Colors.white,),
            SizedBox(width: width*0.05,),
            Text(text,style: TextStyle(color: Colors.white),)
          ],
        ),
      ),
   );
  }


  Widget newsContainer(double height,double width,Article article){
    return InkWell(
      onTap: ()=> _launchUrl(article.url),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: height*0.05),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(height*0.2)),
        child: Container(
          height: height,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: width*0.05,),
              CircleAvatar(
                radius: width*0.15,
                backgroundImage:article.urlToImage==''? null : CachedNetworkImageProvider(article.urlToImage),
                child: article.urlToImage==''? Text('No image') : SizedBox(),
              ),
              SizedBox(width: width*0.05,),
              Container(
                height: height*0.9,
                width: width*0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height:height*0.3,child: Text(article.title,overflow: TextOverflow.ellipsis,maxLines: 3,style: TextStyle(fontWeight: FontWeight.w700),)),
                    SizedBox(height: height*0.05,),
                    Container(height: height*0.2,child: Text('Author: ${article.author}',style: TextStyle(fontWeight: FontWeight.w500),)),
                    SizedBox(height: height*0.05,),
                    Container(height:height*0.3, child: Text(article.description,maxLines: 4,overflow: TextOverflow.fade,))
                  ],
                ),
              ),
              SizedBox(width: width*0.05,)
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(){
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch url',style: TextStyle(color: Colors.white),)
          ,backgroundColor: Colors.red,)
    );
  }

  void _launchUrl(String url) async {
    bool online =await  isConnected();
    if(!online){
      showSnackBar();
      return;
    }
     bool success = await launchUrl(Uri.parse(url)).catchError((_)=>false);
     if(!success){
       showSnackBar();
     }
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
