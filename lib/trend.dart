import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coronaware/trend_model.dart';
import 'package:coronaware/constraints.dart';

class Trend extends StatefulWidget {
  @override
  _TrendState createState() => _TrendState();
}

class _TrendState extends State<Trend> {
  bool _loading = false;
  String dropdownValue = 'Country';
  String place;
  var trendCorona;
  String cases = '';
  String deaths = '';
  String todayCases = '';
  String todayDeaths = '';
  String recovered = '';
  String active = '';
  String tests = '';
  String casePerMillion = '';
  String deathPerMillion = '';

  void getInfo() async{

    if(dropdownValue == 'Continent'){
      trendCorona = await TrendCorona().getTrendContinentData(place);
      print(trendCorona);
    }
    if(dropdownValue == 'Country'){
      trendCorona = await TrendCorona().getTrendCountryData(place);
    }
    setState(() {
      if(trendCorona == null){
      _loading = false;
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Row(
          children: [
            Icon(Icons.place),
            SizedBox(width: 20,),
            Expanded(
              child: Text("Enter correct region"),
            )
          ],
        )),
      );

        cases = 'something went wrong';
        deaths = 'something went wrong';
        todayCases = 'something went wrong';
        todayDeaths = 'something went wrong';
        recovered = 'something went wrong';
        active = 'something went wrong';
        tests = 'something went wrong';
        casePerMillion = 'something went wrong';
        deathPerMillion = 'something went wrong';
      }
      else {
        _loading = false;
        cases = trendCorona['cases'].toString();
        deaths = trendCorona['deaths'].toString();
        todayCases = trendCorona['todayCases'].toString();
        todayDeaths = trendCorona['todayDeaths'].toString();
        recovered = trendCorona['recovered'].toString();
        active = trendCorona['active'].toString();
        tests = trendCorona['tests'].toString();
        casePerMillion = trendCorona['casesPerOneMillion'].toString();
        deathPerMillion = trendCorona['deathsPerOneMillion'].toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CORONA TREND',
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold
          )),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Container(
        color: Colors.black26,
        child: ListView(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                padding: const EdgeInsets.only(top: 20),
                    child: DropdownButton(

                        value: dropdownValue,
                        icon: Icon(Icons.arrow_drop_down_circle_outlined),
                        iconSize: 20,
                        elevation: 16,
                        dropdownColor: Colors.indigo,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16

                        ),

                        underline: Container(
                          height: 2,
                          color: Colors.indigoAccent,
                        ),
                        onChanged: (var newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>['Continent','Country']
                      .map<DropdownMenuItem<String>>((String value){
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                        }).toList(),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                    child: TextField(

                      textAlign: TextAlign.center,
                      onChanged: (value){
                        place = value.toLowerCase();
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Region',
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0))
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigoAccent,width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0))
                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigoAccent,width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(32.0))
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                      onPressed:() {
                        setState(() {
                          _loading = true;
                        });
                        getInfo();
                        },

                        style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.indigoAccent)
                        ),
                        child: Text('SHOW',
                        style: TextStyle(fontWeight: FontWeight.bold,
                        color: Colors.white),
                        )
                        )
                        ],
                        ),
                        ),
                        SizedBox(height: 20,
                        width: 10,
                        child: Divider(thickness: 2,),),
                        _loading ? Center(
                        child: Container(
                        child: CircularProgressIndicator(),
                        ),
                        ): Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                          child: Column(

                            children: <Widget>[
                              Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                elevation: 10,
                                child: ListTile(
                                  leading: Icon(Icons.local_hospital_rounded,
                                  color: Colors.black,),
                                  title: Text(cases,
                                  style: TextStyle(fontSize: 20,
                                      color: Colors.black),),
                                  subtitle: Text('Total Cases',
                                    style: TextStyle(color: Colors.black),),
                                  dense: true,
                                  tileColor: Colors.lightBlueAccent,

                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                elevation: 5,
                                child: ListTile(
                                  leading: Icon(Icons.airline_seat_flat_sharp,
                                    color: Colors.black,),
                                  title: Text(deaths,
                                    style: TextStyle(fontSize: 20,
                                        color: Colors.black),),
                                  subtitle: Text('Total Deaths',
                                    style: TextStyle(color: Colors.black),),
                                  dense: true,
                                  tileColor: Colors.lightBlueAccent,

                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                elevation: 5,
                                child: ListTile(
                                  leading: Icon(Icons.local_hospital_rounded,
                                    color: Colors.black,),
                                  title: Text(todayCases,
                                    style: TextStyle(fontSize: 20,
                                        color: Colors.black),),
                                  subtitle: Text('Cases Today',
                                    style: TextStyle(color: Colors.black),),
                                  dense: true,
                                  tileColor: Colors.lightBlueAccent,

                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                elevation: 5,
                                child: ListTile(
                                  leading: Icon(Icons.airline_seat_flat_sharp,
                                    color: Colors.black,),
                                  title: Text(todayDeaths,
                                    style: TextStyle(fontSize: 20,
                                        color: Colors.black),),
                                  subtitle: Text('Deaths Today',
                                    style: TextStyle(color: Colors.black),),
                                  dense: true,
                                  tileColor: Colors.lightBlueAccent,

                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                elevation: 5,
                                child: ListTile(
                                  leading: Icon(Icons.accessibility_new_rounded,
                                    color: Colors.black,),
                                  title: Text(recovered,
                                    style: TextStyle(fontSize: 20,
                                        color: Colors.black),),
                                  subtitle: Text('Total Recovered',
                                    style: TextStyle(color: Colors.black),),
                                  dense: true,
                                  tileColor: Colors.lightBlueAccent,

                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                elevation: 5,
                                child: ListTile(
                                  leading: Icon(Icons.airport_shuttle,
                                    color: Colors.black,),
                                  title: Text(active,
                                    style: TextStyle(fontSize: 20,
                                        color: Colors.black),),
                                  subtitle: Text('Total Active Cases',
                                    style: TextStyle(color: Colors.black),),
                                  dense: true,
                                  tileColor: Colors.lightBlueAccent,

                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                elevation: 5,
                                child: ListTile(
                                  leading: Icon(Icons.medical_services,
                                    color: Colors.black,),
                                  title: Text(tests,
                                    style: TextStyle(fontSize: 20,
                                        color: Colors.black),),
                                  subtitle: Text('Total Tests Conducted',
                                    style: TextStyle(color: Colors.black),),
                                  dense: true,
                                  tileColor: Colors.lightBlueAccent,

                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                elevation: 5,
                                child: ListTile(
                                  leading: Icon(Icons.accessibility_rounded,
                                    color: Colors.black,),
                                  title: Text(casePerMillion,
                                    style: TextStyle(fontSize: 20,
                                        color: Colors.black),),
                                  subtitle: Text('Cases Per Million',
                                    style: TextStyle(color: Colors.black),),
                                  dense: true,
                                  tileColor: Colors.lightBlueAccent,

                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                elevation: 5,
                                child: ListTile(
                                  leading: Icon(Icons.airline_seat_individual_suite,
                                    color: Colors.black,),
                                  title: Text(deathPerMillion,
                                    style: TextStyle(fontSize: 20,
                                        color: Colors.black),),
                                  subtitle: Text('Deaths Per Million',
                                    style: TextStyle(color: Colors.black),),
                                  dense: true,
                                  tileColor: Colors.lightBlueAccent,

                                ),
                              ),

                ],

                          ),
                        )
          ],
        ),
      )
    );
  }
}
