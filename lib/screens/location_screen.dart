import 'package:flutter/material.dart';
import 'package:weather_forcasting_app/utilities/constants.dart';
import 'package:weather_forcasting_app/services/weather.dart';
import 'city_screen.dart';
import 'loading_screen.dart';

class LocationScreen extends StatefulWidget {

  final locationweather;
  LocationScreen({this.locationweather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = new WeatherModel();
  int temperature;
  String weathercondition;
  String cityname;
  String weathermessage;
  @override
  void initState(){
    super.initState();
    updateui(widget.locationweather);
}
void updateui(dynamic weatherdata){

    setState(() {
      if(weatherdata == null)
        {
          temperature = 0;
          weathercondition = 'error';
          weathermessage = 'unable to fetch';
          cityname = '';
          return;
        }
      else{
      double temp = weatherdata['main']['temp'];
      var condition = weatherdata['weather'][0]['id'];
      cityname = weatherdata['name'];
      temperature = temp.toInt();
      weathercondition = weather.getWeatherIcon(condition);
      weathermessage = weather.getMessage(temperature);
    }
    }
    );
}
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{
                      var weatherdata = await weather.getlocationweather();
                      updateui(weatherdata);

                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                    var typedname = await  Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                    if(typedname != null)
                      {
                      var weatherdata = await weather.getcityweather(typedname);
                      updateui(weatherdata);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weathercondition,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weathermessage in $cityname!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

