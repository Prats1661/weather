import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() => runApp(
      MaterialApp(
        title: "Weather App",
        home: Home(),
      )
);


class Home extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}
class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windspeed;

  Future getWeather () async {
    http.Response response = await http.get("http://api.openweathermap.org/data/2.5/weather?q=Nagpur&units=imperial&appid=b3ea3e69b076d9cccd12b310aebbade7");
        var results= jsonDecode(response.body);
        setState(() {
          this.temp = results['main']['temp'];
          this.description = results['weather'][0]['description'];
          this.currently = results['weather'][0]['main'];
          this.humidity = results['main']['humidity'];
          this.windspeed = results['wind']['speed'];

        });


  }
  @override
  void initState (){
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width,
            color:Colors.blueGrey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.2),
                     child: Text(
                      " Nagpur",
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600
                     ),

                   ),
    ),
                    Text(
                      temp != null ? temp.toString() + "\u00B0" : "loading",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 42.0,
                        fontWeight: FontWeight.w600

                      ),

                   ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Text(
                     currently !=null ? currently.toString() : "loading",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34.0,
                          fontWeight: FontWeight.w600
                      ),

                    ),
                  ),

                  ],
      
              ),
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                      title:Text("Temperature"),
                      trailing: Text(temp !=null ? temp.toString()+ "\u00B0" : "loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.cloud),
                      title:Text("Weather"),
                      trailing: Text(description != null ? description.toString() : "loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.sun),
                      title:Text("Humidity"),
                      trailing: Text(humidity != null ? windspeed.toString(): "loading"),
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.wind),
                      title:Text("Wind Speed"),
                      trailing: Text(windspeed != null ? windspeed.toString():"loading"),
                    ),
                  ],
                ),
              ),
          ),
    ],
      ),
    );

  }
}

