import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:weather_forcasting_app/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    getlocationdata();
    //getdata();
  }
  void getlocationdata() async {
    WeatherModel weather = new WeatherModel();
    var weatherdata = await weather.getlocationweather();
     Navigator.push(context, MaterialPageRoute(builder: (context){

       return LocationScreen(locationweather: weatherdata,);
     }));

    }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
