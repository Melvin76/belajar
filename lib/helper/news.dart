import 'dart:convert';

import 'package:berita/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {

  List<ArticleModel> news = [];

  
Future<void> getNews() async{
  
  String url ="http://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=40bdc7594beb416bb9c49ffda2f2d505";
  
  var response = await http.get(url);

  var jsonData = jsonDecode(response.body);

  if(jsonData['status'] == 'ok'){
    jsonData["articles"].forEach((element){

      if(element["urlTotImage"] != null && element["description"] != null){

        ArticleModel articleModel = ArticleModel(        
         title : element["title"],
         author : element["author"],
         description : element["description"],
         url : element["url"],
         urlTotImage : element["urlTotImage"],
         content : element["content"]
        );
        
        news.add(articleModel);

      }
    });
  }

}

}

class CategoryNewsClass {

  List<ArticleModel> news = [];

  
Future<void> getNews(String category) async{
  
  String url ="http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=40bdc7594beb416bb9c49ffda2f2d505";
  
  var response = await http.get(url);

  var jsonData = jsonDecode(response.body);

  if(jsonData['status'] == 'ok'){
    jsonData["articles"].forEach((element){

      if(element["urlTotImage"] != null && element["description"] != null){

        ArticleModel articleModel = ArticleModel(        
         title : element["title"],
         author : element["author"],
         description : element["description"],
         url : element["url"],
         urlTotImage : element["urlTotImage"],
         content : element["content"]
        );
        
        news.add(articleModel);

      }
    });
  }

}

}


