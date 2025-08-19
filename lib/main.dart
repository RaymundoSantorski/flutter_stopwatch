import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stepwatch_practice/helpers/format_number.dart';

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
  Duration duration = Duration();
  bool running = false;

  Future<void> stopwatchFunction() async {
    if (running == false) return;
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      duration = Duration(seconds: duration.inSeconds + 1);
    });
    stopwatchFunction();
  }

  Future<void> pauseStopwatch() async {
    setState(() {
      running = false;
    });
  }

  Future<void> stopStopwatch() async {
    running = false;
    await Future.delayed(Duration(seconds: 1));
    duration = Duration();
    setState(() {});
  }

  Future<void> restartStopWatch() async {
    await pauseStopwatch();
    await Future.delayed(Duration(seconds: 1));
    await stopStopwatch();
    startStopwatch();
  }

  Future<void> startStopwatch() async {
    setState(() {
      running = true;
    });
    stopwatchFunction();
  }

  ColorScheme buttonStyle = ColorScheme(
    brightness: Brightness.light,
    primary: Colors.blue,
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: Colors.blue,
    error: Colors.redAccent,
    onError: Colors.black,
    surface: Colors.grey,
    onSurface: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(formatNumber(duration.inMinutes)),
            Text(':'),
            Text(formatNumber(duration.inSeconds - duration.inMinutes * 60)),
          ],
        ),
        duration.inSeconds == 0
            ? CupertinoButton(
                color: buttonStyle.primary,
                onPressed: startStopwatch,
                child: Text(
                  'Iniciar',
                  style: TextStyle(color: buttonStyle.onPrimary),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  running
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: buttonStyle.primary,
                              width: 3.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            color: buttonStyle.primary,
                          ),
                          child: CupertinoButton(
                            color: buttonStyle.primary,
                            onPressed: pauseStopwatch,
                            child: Text(
                              '   Pausar  ',
                              style: TextStyle(color: buttonStyle.onPrimary),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: buttonStyle.primary,
                              width: 3.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            color: buttonStyle.primary,
                          ),
                          child: CupertinoButton(
                            color: buttonStyle.primary,
                            onPressed: startStopwatch,
                            child: Text(
                              'Continuar',
                              style: TextStyle(color: buttonStyle.onPrimary),
                            ),
                          ),
                        ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: buttonStyle.onSecondary,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: CupertinoButton(
                      onPressed: () {
                        stopStopwatch();
                        startStopwatch();
                      },
                      child: Text(
                        'Reiniciar',
                        style: TextStyle(color: buttonStyle.onSecondary),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: buttonStyle.error, width: 3.0),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: buttonStyle.onPrimary,
                    ),
                    child: CupertinoButton(
                      onPressed: stopStopwatch,
                      child: Text(
                        'Detener',
                        style: TextStyle(color: buttonStyle.error),
                      ),
                    ),
                  ),
                ],
              ),
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

  void startTimer() {
    if (duration.inSeconds == 0) return;
    setState(() {
      running = true;
    });
    timerFunction();
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
                onPressed: duration.inSeconds > 0 ? startTimer : null,
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
