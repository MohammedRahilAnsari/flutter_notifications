import 'package:flutter/material.dart';

import '../services/notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///Creating instance for Notification Services.
  NotificationService notificationService = NotificationService();

  ///Once user is in homepage of the app they'll get permission request for Notification.
  @override
  void initState() {
    super.initState();
    notificationService.requestNotificationPermission();
    notificationService.getDeviceToken();
    notificationService.getRefreshToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Notification Reference'),
      ),
      body: const Center(
        child: Text('Flutter Notification Reference'),
      ),
    );
  }
}
