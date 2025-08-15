import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;

  void setIndex(value) {
    setState(() {
      _index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    String title = _index == 0 ? 'Stopwatch' : 'Timer';
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: setIndex,
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

class MyStopWatch extends StatefulWidget {
  const MyStopWatch({super.key});

  @override
  State<MyStopWatch> createState() => _MyStopWatchState();
}

class _MyStopWatchState extends State<MyStopWatch> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyTimer extends StatefulWidget {
  const MyTimer({super.key});

  @override
  State<MyTimer> createState() => _MyTimerState();
}

class _MyTimerState extends State<MyTimer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
