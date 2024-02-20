import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../main.dart';
import '../../module/notifications/Screens/loan_collection_detail.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {}
  debugPrint('title:${message.notification?.title}');
  debugPrint('body:${message.notification?.body}');
  debugPrint('payload:${message.data}');
}

class FirebaseHelperApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final androidChannel = const AndroidNotificationChannel(
    'high_importance_chnnel',
    'High Importance Notifications',
    description: 'use noification',
    importance: Importance.defaultImportance,
  );
  final localNotification = FlutterLocalNotificationsPlugin();
  // Future initPushNotification() async {
  //   await FirebaseMessaging.instance
  //       .setForegroundNotificationPresentationOptions(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );
  // }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (_) => LoanCollectionDetailScreen(),
    ));
  }

  Future initLocalNotifications() async {
    const ios = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/logopng');
    const setting = InitializationSettings(android: android, iOS: ios);
    await localNotification.initialize(setting,
        onDidReceiveNotificationResponse: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
      handleMessage(message);
    });
    final platform = localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((value) => handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            androidChannel.id,
            androidChannel.name,
            channelDescription: androidChannel.description,
            icon: '@drawable/logopng',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    // final fCMToken = await _firebaseMessaging.getToken();
    // debugPrint("Token:$fCMToken");
    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    if (Platform.isAndroid) {
      initPushNotifications();
    }
    initLocalNotifications();
  }
}
