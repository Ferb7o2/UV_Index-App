import 'package:flutter/material.dart';
import 'chart.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
              0.40,
              1
            ],
                colors: [
              Color(0xffF75900), // Orange
              Color(0xffFFE800) //Yellow
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.menu),
              iconSize: 38,
              onPressed: () {},
            ),
            title: Text(
              "UV Index",
              style: TextStyle(
                  fontSize: 38,
                  fontFamily: 'Roboto',
                  color: Color(0xffFFFFFF),
                  shadows: [
                    Shadow(
                        color: Colors.black.withOpacity(.3),
                        offset: Offset(3, 3),
                        blurRadius: 10),
                  ]),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              child: Container(
                color: Colors.white,
                height: 1.2,
              ),
              preferredSize: Size.fromHeight(10),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'McAllen',
                  style: TextStyle(
                      fontSize: 54,
                      fontFamily: 'Roboto',
                      color: Color(0xffFFFFFF),
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(.35),
                            offset: Offset(4, 4),
                            blurRadius: 7),
                      ]),
                ),
                Padding(padding: EdgeInsets.only(bottom: 8)),
                Text(
                  "Partly cloudy",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      color: Color(0xffFFFFFF),
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(.3),
                            offset: Offset(4, 4),
                            blurRadius: 10),
                      ]),
                ),
                Padding(padding: EdgeInsets.only(bottom: 8)),
                Text(
                  "7",
                  style: TextStyle(
                      fontSize: 200,
                      fontFamily: 'Roboto',
                      color: Color(0xffFFFFFF),
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(.3),
                            offset: Offset(4, 4),
                            blurRadius: 8),
                      ]),
                ),
                Text(
                  "High Exposure",
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      color: Color(0xffFFFFFF),
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(.3),
                            offset: Offset(4, 4),
                            blurRadius: 8),
                      ]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 28, left: 0, right: 5),
                  child: LineChartSample2(),
                ),

                //Padding(padding: EdgeInsets.only(bottom: 240)),
              ],
            ),
          ),
        ));
  }
}
