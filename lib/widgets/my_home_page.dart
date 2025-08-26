import 'package:flutter/material.dart';
import 'package:stepwatch_practice/screens/my_stopwatch.dart';
import 'package:stepwatch_practice/screens/my_timer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;

  void setIndex(int value) {
    setState(() {
      _index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    String title = _index == 0 ? 'Stopwatch' : 'Timer';
    Color color = _index == 0 ? Colors.pinkAccent : Colors.blue;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: color,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: setIndex,
        selectedItemColor: color,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_rounded),
            label: 'Stopwatch',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Timer'),
        ],
      ),
      body: _index == 0 ? MyStopWatch() : MyTimer(),
    );
  }
}
