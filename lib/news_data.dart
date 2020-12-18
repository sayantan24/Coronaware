import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:coronaware/articles.dart';

class NewsHelper{
  String url = 'http://newsapi.org/v2/everything?q=coronavirus&language=en&sortBy=publishedAt&apiKey=d8e567b12a004f499a102c58fe3befa4';

  List<ArticleModel> news_reports = [];

  Future getData() async{
    var response =  await http.get(url);

    var data = jsonDecode(response.body);

    if(data['status']=='ok'){
     data["articles"].forEach((element){
       if(element['description']!=null && element['urlToImage']!=null){

         ArticleModel articleModel = ArticleModel(
           author: element['author'],
           title: element['title'],
           Description: element['description'],
           urlImage: element['urlToImage'],
           url: element['url']
         );
         news_reports.add(articleModel);

       }

     });
    }


  }

}