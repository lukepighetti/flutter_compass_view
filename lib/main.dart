import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

import 'compass_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_compass_view',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double? _bearing;

  void _setBearing(double heading) {
    setState(() {
      _bearing = heading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        final heading = snapshot.data?.heading ?? 0;

        return Scaffold(
          backgroundColor: Colors.black,
          body: Align(
            alignment: const Alignment(0, -0.2),
            child: CompassView(
              bearing: _bearing,
              heading: heading,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _setBearing(heading),
            tooltip: 'Set Bearing',
            child: const Icon(Icons.arrow_upward),
          ),
        );
      },
    );
  }
}
