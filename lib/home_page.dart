import 'dart:convert';

import 'package:flutter/material.dart';
import 'chart.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  getUserData() async {
    var latitude = _locationData.latitude.toString();
    var longitude = _locationData.longitude.toString();

    var responseCity = await http.get(
        Uri.https('api.weather.gov', 'points/' + latitude + "," + longitude));

    var jsonDataCity = jsonDecode(responseCity.body);

    var city =
        jsonDataCity['properties']['relativeLocation']['properties']['city'];
    var state =
        jsonDataCity['properties']['relativeLocation']['properties']['state'];

    var response = await http.get(Uri.https(
        'enviro.epa.gov',
        '/enviro/efservice/getEnvirofactsUVHOURLY/CITY/' +
            city +
            '/STATE/' +
            state +
            '/JSON'));

    var jsonData = jsonDecode(response.body);

    List<String> uvMap = [];

    //#0 index starts at 6am and ends at 2am next day
    for (var i = 12; i < jsonData.length + 15; i++) {
      if ((i - 12) <= 5) {
        uvMap.add("0");
      } else
        uvMap.add(jsonData[i - 18]['UV_VALUE'].toString());
    }

    var time = jsonData[0]['DATE_TIME'].substring(12, 17);

    var uvIndex = jsonData[0]['UV_VALUE'].toString();

    // GET FORECAST TEXT

    var forecastURL = jsonDataCity['properties']['forecastHourly'];

    var responseForecast = await http.get(Uri.https(
        forecastURL.substring(8, 23),
        forecastURL.substring(24, forecastURL.length)));

    var jsonDataForecast = jsonDecode(responseForecast.body);

    var forecast =
        jsonDataForecast['properties']['periods'][0]['shortForecast'];

    print("ZIP -> " + time + ": " + uvIndex);
    print(longitude + "," + latitude);

    print(city + ", " + state);

    String now = new DateTime.now().toString().substring(11, 13);

    int hour = int.parse(now);
    //print(hour);

    //print(hour.runtimeType);

    // print(new DateTime.now().toString().substring(11, 13));

    setState(() {
      localCity = city;
      localState = state;
      localForecast = forecast;
      localUvMap = uvMap;
      localHour = hour;
    });
  }

  var localCity = "";
  var localState = "";
  var localForecast = "Loading...";
  var localUvMap = List<String>.filled(24, "0");
  var localHour = 5;

  Location location = new Location();
  bool _serviceEnabled = false;

  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  bool _isListenLocation = false, _isGetLocation = false;

  void loadData() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled) return;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();

      if (_permissionGranted != PermissionStatus.granted) return;
    }

    _locationData = await location.getLocation();

    setState(() {
      _isGetLocation = true;
    });

    getUserData();
  }

  //on load trigger
  void initState() {
    super.initState();
    loadData();
  }

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
              Color(0xffF75900), //Hello // Orange
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
                  localCity + ", " + localState,
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
                  localForecast,
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
                  localUvMap[localHour],
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
