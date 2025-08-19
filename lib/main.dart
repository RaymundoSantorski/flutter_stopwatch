import 'package:flutter/cupertino.dart';
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
    return Column(children: [
      ],
    );
  }
}

class MyTimer extends StatefulWidget {
  const MyTimer({super.key});

  @override
  State<MyTimer> createState() => _MyTimerState();
}

class _MyTimerState extends State<MyTimer> {
  Duration duration = Duration(minutes: 0, seconds: 0);
  bool running = false;

  Future<void> timerFunction() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      duration = Duration(seconds: duration.inSeconds - 1);
    });
    if (duration.inSeconds >= 0) {
      timerFunction();
    } else {
      exitTimer();
    }
  }

  void exitTimer() {
    setState(() {
      duration = Duration();
      running = false;
    });
  }

  void _setDuration(Duration value) {
    setState(() {
      duration = value;
    });
  }

  String formatNumber(int value) {
    if (value >= 10) {
      return '$value';
    }
    return '0$value';
  }

  @override
  Widget build(BuildContext context) {
    return running
        ? Column(
            children: [
              Row(
                children: [
                  Text(formatNumber(duration.inMinutes)),
                  Text(':'),
                  Text(
                    formatNumber(duration.inSeconds - duration.inMinutes * 60),
                  ),
                ],
              ),
              CupertinoButton(
                onPressed: exitTimer,
                color: Colors.blue,
                child: Text(
                  'Detener',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        : Column(
            children: [
              CupertinoTimerPicker(
                onTimerDurationChanged: _setDuration,
                mode: CupertinoTimerPickerMode.ms,
              ),
              CupertinoButton(
                onPressed: () {
                  setState(() {
                    running = true;
                  });
                  timerFunction();
                },
                color: Colors.blue,
                child: Text(
                  'Iniciar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
  }
}
