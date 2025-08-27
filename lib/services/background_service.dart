// Función que ejecuta el workManager
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Inicialización de FlutterLocalNotificationsPlugin
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    // Se muestra la notificación
    if (task == 'showNotification') {
      _showNotification(flutterLocalNotificationsPlugin);
    }

    return Future.value(true);
  });
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  print(
    'Notificación tocada en segundo plano con payload: ${notificationResponse.payload}',
  );
}

// Función para mostrar la notificación
Future<void> _showNotification(
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
) async {
  const DarwinNotificationDetails iosPlatformChannelSpecifics =
      DarwinNotificationDetails();
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'timer_id',
        'timer',
        channelDescription: 'Notificaciones del estado del temporizador',
        importance: Importance.max,
        priority: Priority.high,
      );
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iosPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    'Timer',
    '¡Tu temporizador terminó!',
    platformChannelSpecifics,
  );
}
