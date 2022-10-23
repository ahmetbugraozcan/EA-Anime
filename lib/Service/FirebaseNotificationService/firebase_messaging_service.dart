import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutterglobal/Service/FirebaseNotificationService/i_firebase_messaging_service.dart';

class FirebaseMessagingService extends IFirebaseMessagingService {
  static FirebaseMessagingService? _instance;

  static FirebaseMessagingService get instance {
    _instance ??= FirebaseMessagingService._init();
    return _instance!;
  }

  FirebaseMessagingService._init();

  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> initLocalNotifications() async {
    try {
      if (Platform.isIOS) {
        await _requestPermission();
      }

      // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      final DarwinInitializationSettings initializationSettingsDarwin =
          DarwinInitializationSettings(
              requestAlertPermission: false,
              requestBadgePermission: false,
              requestSoundPermission: false,
              onDidReceiveLocalNotification: onDidReceiveLocalNotification);

      final InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
      );

      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.max,
      );

      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (details) {
          onSelectNotification(details);
        },
      );
    } catch (e) {
      print("[HATA] [FirebaseMessagingService] [initLocalNotifications] --> " +
          e.toString());
      return null;
    }
  }

  // Android notification selected
  void onSelectNotification(NotificationResponse? payload) {
    print("--onSelectNotification-- ANDROID --");

    print("payload: ${payload!.payload}");
    print("payload2: ${payload.notificationResponseType}");
  }

  @override
  Future<void> initService() async {
    try {
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      print('User granted permission: ${settings.authorizationStatus}');

      // use the returned token to send messages to users from your custom server
      String? token = await _messaging.getToken();

      // TODO : Update the token in the server

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        print("onMessage.listen : ${message.data}");
        if (message.notification != null) {
          print(message.toMap());
          await displayNotification(message);
        }
      });
    } catch (e) {
      print("[HATA] [FirebaseMessagingService] [initService] --> " +
          e.toString());
    }
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
  }

  Future<void> displayNotification(RemoteMessage message) async {
    print("mesaj tipi :${message.data.toString()}");

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'basic_notification',
      'Basic Notification',
      styleInformation: DefaultStyleInformation(false, false),
      channelDescription: 'Her Şey Anime Temel Bildirimleri',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails iosPlatformChannelSpecifics =
        DarwinNotificationDetails();

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    if (message.notification != null) {
      if (message.notification!.title != null &&
          message.notification!.body != null) {
        await _flutterLocalNotificationsPlugin.show(
          Random().nextInt(5),
          '${message.notification?.title}',
          '${message.notification?.body}',
          platformChannelSpecifics,
        );
      }
    }
  }

// IOS uygulama açıkken bildirim gönderildiğinde çalışır
  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print("onDidReceiveLocalNotification");
    print("id: $id");
    print("title: $title");
    print("body: $body");
    print("payload: $payload");
  }

  Future<void> _requestPermission() async {
    final bool? result = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: false,
          badge: true,
          sound: true,
        );
  }
}
