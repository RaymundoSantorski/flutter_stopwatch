import 'package:flutter/material.dart';
import 'package:stepwatch_practice/widgets/my_home_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // Lógica para manejar la notificación en segundo plano
  print(
    'Notificación tocada en segundo plano con payload: ${notificationResponse.payload}',
  );
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(
    iOS: initializationSettingsDarwin,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
          // Lógica para manejar la notificación en primer plano
          print(notificationResponse.payload);
        },
    // 2. Pasar la referencia a la función top-level.
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

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
