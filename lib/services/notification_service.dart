import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  /// Initializing Firebase Messaging package.
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

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
    return token!;
  }

  getRefreshToken() {
    firebaseMessaging.onTokenRefresh.listen((event) {
      event.toString();
      debugPrint('refreshed Token ${event.toString()}');
    });
  }
}
