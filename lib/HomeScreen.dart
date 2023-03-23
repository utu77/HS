// ignore_for_file: file_names, prefer_const_constructors

import 'package:demo_project/Charts/CandleChart.dart';
import 'package:demo_project/Charts/HiloOpenCloseChart.dart';
import 'package:demo_project/Charts/LineChart.dart';

import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import 'WebSocketTask.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks "),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _list(
                title: "Web Socket Task",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => WebSocketTask(),
                      ));
                }),
            _list(
                title: "Candle Chart",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => CandleChart(),
                      ));
                }),
            _list(
                title: "Line Chart",
                onTap: () {
                  Vibration.vibrate(duration: 500);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => LineChart(),
                      ));
                }),
            _list(
                title: "Hilo Open Close Chart",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => HiloOpenCloseChart(),
                      ));
                }),
          ],
        ),
      ),
    );
  }

  Widget _list({
    String? title,
    Function? onTap,
  }) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          alignment: Alignment.center,
          height: 75,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 138, 138),
            border: Border.all(color: Colors.black, width: 4),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Text(
            title!,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
