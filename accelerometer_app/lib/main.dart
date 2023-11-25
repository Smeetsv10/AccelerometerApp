import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:html' as html;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Accelerometer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accelerometer Data'),
      ),
      body: AccelerometerDataWidget(),
    );
  }
}

class AccelerometerDataWidget extends StatefulWidget {
  @override
  _AccelerometerDataWidgetState createState() =>
      _AccelerometerDataWidgetState();
}

class _AccelerometerDataWidgetState extends State<AccelerometerDataWidget> {
  List<double> accelerometerValues = [0, 0, 0];
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      userAccelerometerEvents.listen(
        (UserAccelerometerEvent event) {
          setState(() {
            accelerometerValues = <double>[event.x, event.y, event.z];
          });
        },
        onError: (e) {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Sensor Not Found"),
                  content: Text(
                      "It seems that your device doesn't support Accelerometer Sensor"),
                );
              });
        },
        cancelOnError: true,
      ),
    );
  }

  // Request sensor permission using JavaScript interop
  // void _requestSensorPermission() {
  //   html.window.navigator.permissions!
  //       .query({'name': 'accelerometer'}).then((html.PermissionStatus status) {
  //     if (status.state == 'granted') {
  //       print('Accelerometer permission granted.');
  //     } else if (status.state == 'prompt') {
  //       print('Requesting accelerometer permission.');
  //     } else {
  //       print('Accelerometer permission denied.');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Accelerometer Data:',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          Text(
            'X: ${accelerometerValues[0].toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Y: ${accelerometerValues[1].toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Z: ${accelerometerValues[2].toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
