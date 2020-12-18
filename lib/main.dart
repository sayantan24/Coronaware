import 'package:flutter/material.dart';
import 'package:coronaware/news.dart';
import 'package:coronaware/trend.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),

      home: Transition(),
    );
  }
}

class Transition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: AnimatedSplashScreen(
          splash: Image.asset('images/coronaware_logo.png'),
          nextScreen: Home(),
      splashTransition: SplashTransition.slideTransition,
        backgroundColor: Colors.white54,
        duration: 3000,
        splashIconSize: 120,
        pageTransitionType: PageTransitionType.bottomToTop,
      ),

    );
  }
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children =
  [
    news(),
    Trend()
  ];

  void onTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: _currentIndex,
        backgroundColor: Colors.indigoAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'News',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up_outlined),
            label: 'Trend',
          ),
        ],
      ),
    );
  }
}



