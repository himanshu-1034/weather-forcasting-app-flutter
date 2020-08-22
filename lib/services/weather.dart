import 'package:weather_forcasting_app/services/location.dart';
import 'package:weather_forcasting_app/services/networking.dart';
import 'package:weather_forcasting_app/utilities/constants.dart';
class WeatherModel {
  Future<dynamic> getcityweather(String cityname) async{
    var url = '$openweathermapurl?q=$cityname&appid=$apikey&units=metric';
    Networkhelper network = new Networkhelper(url: url);
    var weatherdata =await network.getdata();
    return weatherdata;
}
  Future<dynamic> getlocationweather() async{
    Location l = new Location();
    await l.getcurrentlocation();
    Networkhelper net = new Networkhelper(url: '$openweathermapurl?lat=${l.latitude}&lon=${l.longitude}&appid=$apikey&units=metric');
    var weatherdata =await net.getdata();
      return weatherdata;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
