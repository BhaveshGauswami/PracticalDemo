import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  String stDeviceId="";
  String stDeviceModel="";
  String? stOsVersion="";
  String stMobilePlatform="";
  String? stFCMToken="";
  /*void getWeatherData(String cityData) {
    ApiService.getWeatherDataByCity(cityData).then((data) {
      Map resultBody = json.decode(data.body);
      if (resultBody['success'] == true) {
        setState(() {
          city = resultBody['city'];
          Iterable result = resultBody['result'];
          weatherList =
              result.map((watherData) => Weather(watherData)).toList();
        });
      }
    });
  }*/
  //https://github.com/devEge/hava-ne-durumda/blob/master/lib/screens/home_screen.dart
}