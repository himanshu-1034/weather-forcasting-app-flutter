import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_forcasting_app/utilities/constants.dart';

class Networkhelper{
  final String url;
  Networkhelper({this.url});
  Future getdata() async {
    http.Response response = await http.get(url);
    var decodeddata;
    if(response.statusCode == 200) {
      String data = response.body;
      decodeddata = jsonDecode(data);

      return decodeddata;
    }
    else
      print(response.statusCode);
  }
}