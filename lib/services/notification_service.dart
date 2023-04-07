import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  /// Initializing Firebase Messaging package.
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  ///Instance of [flutter_local_notification]
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  ///Asking for user permission.
  ///If by any chance user denies the permission, user have to give permission manually.
  ///This function is called in HomeScreen.dart init method.
  void requestNotificationPermission() async {
    NotificationSettings notificationSettings = await firebaseMessaging.requestPermission(
      ///Alert is to set show notification on users device.
      alert: true,

      ///Announcement is to make voice assistance to read notification.
      announcement: true,

      ///Badge is to show indicator on the app if there is notification in shutter.
      badge: true,
      carPlay: true,
      criticalAlert: true,

      ///Provisional add flexibility for user to turn on or off directly from notification panel.
      provisional: true,
      sound: true,
    );

    ///checking user action on Notification Permission Request
    ///if condition is checking permission request for [Android] devices
    ///else if condition is checking permission request for [IOS] devices
    if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('permission authorized');
    } else if (notificationSettings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint('provisional permission authorized');
    } else {
      ///This will help to redirect app in settings where user will grand notification permission.
      AppSettings.openNotificationSettings();
      debugPrint('permission denied');
    }
  }

  ///getting [Device] token of user
  Future<String> getDeviceToken() async {
    String? token = await firebaseMessaging.getToken();
    debugPrint('token $token');
    return token??'';
  }

  ///Token can be change due to some reason,
  ///So by checking token is refreshed or not we can keep our device token up to date.
  ///onTokenRefresh is a Stream and it helps to check if there is any changes in token
  Future<String> getRefreshToken() async {
    String? newToken;
    firebaseMessaging.onTokenRefresh.listen((event) {
      newToken = event.toString();
      debugPrint('refreshed Token $newToken');
    });
    return newToken ?? '';
  }

  ///This function will help us to initialize [flutter_local_notification] and handle both [android] & [ios] notification,
  ///This method need [context] to show UI and [remoteMessage] which is coming from firebase notification
  void localNotificationInit() async {
    ///Update your notification Icons by changing below string value
    // var defaultIcon = ;

    var androidInitialization = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialization = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitialization,
      iOS: iosInitialization,
    );

    ///Initializing [flutter_local_notification] ,
    ///Payload - payload is data coming from remoteMessage [firebase notification message],
    ///Which will help us to set data in notification ui.
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {},
    );
  }

  ///Foreground App Notification
  void isAppInNotificationInit() {
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint(message.notification?.title);
      debugPrint(message.notification?.body);
      showNotification(message);
    });
  }

  ///show Notification
  Future<void> showNotification(RemoteMessage message) async {
    ///Android channel and Notification Details
    ///Channel Details
    AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
      Random.secure().nextInt(10000).toString(),
      'channelName',
      importance: Importance.max,
      enableVibration: true,
      showBadge: true,
      playSound: true,
    );

    ///Notifications Details
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      androidNotificationChannel.id,
      androidNotificationChannel.name,
      channelDescription: 'channelDescription',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher'
    );

    ///IOS channel and Notification Details
    DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      interruptionLevel: InterruptionLevel.active,
    );

    ///Assigning [Android] & [IOS] settings
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    ///below future delay will show dialog [NotificationDialog] user interface/ UI
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        1,
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
      );
    });
  }
}

