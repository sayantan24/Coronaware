import 'package:coronaware/trend_data.dart';
import 'package:flutter/material.dart';

class TrendCorona{
  Future<dynamic> getTrendContinentData(String place) async{
    TrendHelper trendHelper = TrendHelper('https://disease.sh/v3/covid-19/continents/$place?strict=true');

    var trendData = await trendHelper.getTrend();
    return trendData;
  }

  Future<dynamic> getTrendCountryData(String place) async{
    TrendHelper trendHelper = TrendHelper('https://disease.sh/v3/covid-19/countries/$place?strict=true');

    var trendData = await trendHelper.getTrend();
    return trendData;
  }
}