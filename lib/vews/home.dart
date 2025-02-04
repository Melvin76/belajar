
import 'package:berita/helper/data.dart';
import 'package:berita/helper/news.dart';
import 'package:berita/models/article_model.dart';
import 'package:berita/models/category_Model.dart';
import 'package:berita/vews/article_view.dart';
import 'package:berita/vews/category_news.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
// ignore: deprecated_member_use
List<CategoryModel> categories = new List<CategoryModel>();
// ignore: deprecated_member_use
List<ArticleModel> articles = new List<ArticleModel>();

bool _loading = true;

@override
void initState() { 
  super.initState();
  categories = getCategories();  
  getNews();
}

getNews() async{
  News newsClass = News();
  await newsClass.getNews();
  articles = newsClass.news;
  setState((){
  _loading = false;  
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text("Flutter"),
            Text("News", style: TextStyle(
              color: Colors.blue
            ),)
          ], 
      ),
      centerTitle: true,
      elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),

          child: CircularProgressIndicator(),
        ),
      )  : SingleChildScrollView(
              child: Container(
          child: Column(
            children: [

              /// categories
              Container(
                height: 70,
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return CategoryTile(
                      imageUrl: categories[index].imageUrl, 
                      categoryName: categories[index].categoryName,
                    );
                  }),
              ),

              /// Blogs
              Container(
                padding: EdgeInsets.only(top: 16),
                child: ListView.builder(
                  itemCount: articles.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index){
                    return BlogTile(
                      imageUrl: articles[index].urlTotImage,
                      title: articles[index].title,
                      desc: articles[index].description,
                      url: articles[index].url,
                      );
                  }),
              )
            ],
          ),
        ),
      ),
      );
  }
}


class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;
  CategoryTile({this.imageUrl,this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryNews(
            category: categoryName.toLowerCase(),
          )
          ));
      },
          child: Container(
        margin: EdgeInsets.only(right: 16,),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imageUrl, width: 120, height: 60, fit: BoxFit.cover,)
              ),
            Container(
              alignment: Alignment.center,
              width: 120, 
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(categoryName, style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),),
            )

          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  BlogTile({@required this.imageUrl,@required this.title,@required this.desc,@required this.url});

  // ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ArticleView(
            blogUrl: url,
          ) 
          ));
      },
          child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl)
            ),
            SizedBox(height: 8,),
            Text(title, style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w500
            ),),
            SizedBox(height: 8,),
            Text(desc, style: TextStyle(
              color: Colors.black54,
            ),),
          ],
        ),
      ),
    );
  }
}