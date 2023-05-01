import 'package:clima/screens/error_message.dart';
import 'package:clima/screens/loading_widget.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import '../utilities/details.dart';
import '../utilities/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double? latitude, longitude;
  bool isdataloaded = false;
  bool iserroroccured = false;
  String? description, icon, name;
  dynamic temp, feelslike, wind, humidity;
  Weather weather = Weather();
  var weatherdata;
  int code = 0;
  String? title, message;

  @override
  void initState() {
    super.initState();
    getpermission();
  }

  GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  LocationPermission? permission;

  void getpermission() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await geolocatorPlatform.requestPermission();
      if (permission != LocationPermission.denied) {
        if (permission == LocationPermission.deniedForever) {
          setState(() {
            isdataloaded = true;
            iserroroccured = true;
            title = 'Permission permanently denied';
            message =
                'Please provide permission to the app from device settings';
          });
        } else {
          updatui();
        }
      } else {
        setState(() {
          isdataloaded = true;
          iserroroccured = true;
          title = 'Permission permanently denied';
          message = 'Please provide permission to the app from device settings';
        });
      }
    } else {
      updatui();
    }
  }

  void updatui({String? cityname}) async {
    weatherdata = null;
    if (cityname == null || cityname == '') {
      if (!await geolocatorPlatform.isLocationServiceEnabled()) {
        setState(() {
          isdataloaded = true;
          iserroroccured = true;
          title = 'Location is turned of';
          message =
              'Please enable the location service to see wether condition for your location';
          return;
        });
      }
      weatherdata = await weather.getlocationweather();
    } else {
      weatherdata = await weather.getcityweather(cityname);
    }

    if (weatherdata == null) {
      setState(() {
        title = 'City not found';
        message = 'Please make sure you have entered the right city name';
        isdataloaded = true;
        iserroroccured = true;
        return;
      });
    }

    code = weatherdata['weather'][0]['id'];
    description = weatherdata['weather'][0]['description'];
    temp = weatherdata['main']['temp'];
    name = weatherdata['name'] + ', ' + weatherdata['sys']['country'];
    feelslike = weatherdata['main']['feels_like'];
    humidity = weatherdata['main']['humidity'];
    wind = weatherdata['wind']['speed'];
    icon =
        'images/weather_icons/${geticon(code)}${weathericons[code.toString()]!['icon']}.svg';
    setState(() {
      isdataloaded = true;
      iserroroccured = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isdataloaded == false) {
      return const Loadingwidget();
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: overlaycolor,
        body: SafeArea(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextField(
                          decoration: textfielddecoration,
                          onSubmitted: (String typedname) {
                            setState(() {
                              isdataloaded = false;
                              updatui(cityname: typedname);
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isdataloaded = false;
                              getpermission();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white12,
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const SizedBox(
                            height: 60,
                            child: Row(
                              children: [
                                Text(
                                  'My Location',
                                  style: textfieldstyle,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.gps_fixed,
                                  color: Colors.white60,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                iserroroccured
                    ? Errormessage(message: message!, title: title!)
                    : Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.location_city,
                                    color: Colors.white60,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    name!,
                                    style: locationtextstyle,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              SvgPicture.asset(
                                icon!,
                                height: 280,
                                color: Colors.white54,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Text(
                                '${temp!.round()}°',
                                style: temptextstyle,
                              ),
                              Text(
                                description!,
                                style: locationtextstyle,
                              ),
                            ]),
                      ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: overlaycolor,
                    child: SizedBox(
                      height: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DetailsWidget(
                            title: 'FEELS LIKE',
                            value:
                                '${weatherdata != null ? feelslike.round() : 0}°',
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: VerticalDivider(
                              thickness: 1,
                            ),
                          ),
                          DetailsWidget(
                            title: 'HUMIDITY',
                            value: '${weatherdata != null ? humidity : 0}%',
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: VerticalDivider(
                              thickness: 1,
                            ),
                          ),
                          DetailsWidget(
                            title: 'WIND',
                            value: '${weatherdata != null ? wind.round() : 0}',
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
