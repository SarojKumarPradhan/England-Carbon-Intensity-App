import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //------------------------------------------------
  var countryName;
  var currentCarbonIntensity;
  var indexPercentage;
  var windPercentage;
  var nuclearPercentage;
  var coalPercentage;
  var importsPercentage;
  var gasPercentage;
  var biomassPercentage;
  var hydroPercentage;
  var solarPercentage;
  var fromDate;
  var toDate;
  void getData() async {
    http.Response response = await http
        .get(Uri.parse('https://api.carbonintensity.org.uk/regional/england'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      String data = response.body;
      var country = jsonDecode(data)['data'][0]['dnoregion'];
      var carbonIntensity =
          jsonDecode(data)['data'][0]['data'][0]['intensity']['forecast'];
      var index = jsonDecode(data)['data'][0]['data'][0]['intensity']['index'];
      var wind =
          jsonDecode(data)['data'][0]['data'][0]['generationmix'][8]['perc'];
      var nuclear =
          jsonDecode(data)['data'][0]['data'][0]['generationmix'][4]['perc'];
      var coal =
          jsonDecode(data)['data'][0]['data'][0]['generationmix'][1]['perc'];
      var imports =
          jsonDecode(data)['data'][0]['data'][0]['generationmix'][2]['perc'];
      var gas =
          jsonDecode(data)['data'][0]['data'][0]['generationmix'][3]['perc'];
      var biomass =
          jsonDecode(data)['data'][0]['data'][0]['generationmix'][0]['perc'];
      var hydro =
          jsonDecode(data)['data'][0]['data'][0]['generationmix'][6]['perc'];
      var solar =
          jsonDecode(data)['data'][0]['data'][0]['generationmix'][7]['perc'];

      var dateFrom = jsonDecode(data)['data'][0]['data'][0]['from'];
      var dateTo = jsonDecode(data)['data'][0]['data'][0]['to'];

      setState(() {
        countryName = country;
        currentCarbonIntensity = carbonIntensity;
        indexPercentage = index;
        windPercentage = wind;
        nuclearPercentage = nuclear;
        coalPercentage = coal;
        importsPercentage = imports;
        gasPercentage = gas;
        biomassPercentage = biomass;
        hydroPercentage = hydro;
        solarPercentage = solar;
        fromDate = dateFrom;
        toDate = dateTo;
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  //------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(fontFamily: 'Ubuntu'),
      home: Scaffold(
        backgroundColor: Color(0xffF6FAFD),
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(5, 5),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Text(
                      '$countryName',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontFamily: 'Ubuntu'),
                    ),
                    Divider(),
                    Text(
                      'Current Carbon Intensity',
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                    Text(
                      '$currentCarbonIntensity',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreen,
                          fontFamily: 'Ubuntu'),
                    ),
                    Text(
                      'gCO2/kWh',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(5, 5),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Text('$fromDate',
                        style: TextStyle(fontSize: 18, color: Colors.teal)),
                    Icon(Icons.arrow_drop_down_sharp),
                    Text('$toDate',
                        style: TextStyle(fontSize: 18, color: Colors.teal)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(5, 5),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Index',
                          style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                        Text(
                          '$indexPercentage',
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Gas',
                          style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                        Text(
                          '$gasPercentage%',
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Wind',
                          style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                        Text(
                          '$windPercentage%',
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nuclear',
                          style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                        Text(
                          '$nuclearPercentage%',
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cola',
                          style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                        Text(
                          '$coalPercentage%',
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Imports',
                          style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                        Text(
                          '$importsPercentage%',
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Biomass',
                          style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                        Text(
                          '$biomassPercentage%',
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hydro',
                          style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                        Text(
                          '$hydroPercentage%',
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Solar',
                          style: TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                        Text(
                          '$solarPercentage%',
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  getData();
                },
                icon: Icon(Icons.refresh),
                label: Text(
                  'Refresh',
                  style: TextStyle(fontFamily: 'Ubuntu'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
