import 'package:coronaware/trend_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrendHelper{
   final String url;
  TrendHelper(this.url);

  Future getTrend() async{
    var response =  await http.get(url);

    if(response.statusCode == 200) {
      var tData = jsonDecode(response.body);
      return tData;

    }


  }
}