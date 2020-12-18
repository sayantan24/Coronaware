import 'dart:convert';
import 'package:coronaware/articles.dart';
import 'package:coronaware/news_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:coronaware/article_view.dart';

//const url = 'http://newsapi.org/v2/everything?q=coronavirus&language=en&from=2020-11-13&sortBy=publishedAt&apiKey=d8e567b12a004f499a102c58fe3befa4';

class news extends StatefulWidget {
  @override
  _newsState createState() => _newsState();
}

// ignore: camel_case_types
class _newsState extends State<news> {
  String data;
  bool _loading;
  List<ArticleModel> articles = new List<ArticleModel>();

  void getNews() async
  {
    NewsHelper newsHelper = NewsHelper();
    await newsHelper.getData();
    articles = newsHelper.news_reports;
    setState(() {
      _loading=false;
    });

  }

  // ignore: must_call_super
  void initState(){
    _loading=true;
    super.initState();
    getNews();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CORONA NEWS',
        style: GoogleFonts.cairo(
          fontWeight: FontWeight.bold
        )),
        backgroundColor: Colors.indigoAccent,
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) :SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 16),
          //child: Text("WOOOOOOOW"),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView.builder(
                itemCount: articles.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                //padding: EdgeInsets.only(top: 10.0),
                
                itemBuilder: (context,index){
                  return BlogTile(
                    title: articles[index].title,
                    desc: articles[index].Description,
                    urlImage: articles[index].urlImage,
                    posturl: articles[index].url,
                  );
                }),
          ),
        ),
      ),

    );
  }
}

class BlogTile extends StatelessWidget {
  final String title,desc,urlImage,posturl;
  BlogTile({@required this.title,@required this.desc,@required this.urlImage,@required this.posturl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleView(
              posturl: posturl,
            )
        ));
      },
      child: Card(
        color: Colors.deepPurple,
        margin: EdgeInsets.only(bottom: 15),
        //width: MediaQuery.of(context).size.width,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 10,
        child: Container(
          child: Container(
            padding: EdgeInsets.symmetric(vertical:8,horizontal: 14),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      urlImage,
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                SizedBox(height: 12,),
                Text(title,
                style: GoogleFonts.muli(
                  fontSize: 22,
                  color: Colors.cyanAccent,
                  fontWeight: FontWeight.bold
                )),
                SizedBox(height: 12,),
                Text(desc,
                style: GoogleFonts.montserrat()),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

