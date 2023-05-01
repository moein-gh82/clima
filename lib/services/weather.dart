import '../utilities/constants.dart';
import 'location.dart';
import 'networking.dart';

class Weather {
  Future<dynamic> getlocationweather() async {
    Location location = Location();
    await location.getcutternlocation();
    Networkhelper networkhelper = Networkhelper(
        url:
            'https://api.openweathermap.org/data/2.5/weather?units=metric&lat=${location.latitude}&lon=${location.longitude}&appid=$apikey');
    var weatherdata = await networkhelper.getdata();
    return weatherdata;
  }

  Future<dynamic> getcityweather(String cityname) async {
    Networkhelper networkhelper = Networkhelper(
        url:
            'https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$apikey&units=metric');
    var weatherdata = await networkhelper.getdata();
    return weatherdata;
  }
}
