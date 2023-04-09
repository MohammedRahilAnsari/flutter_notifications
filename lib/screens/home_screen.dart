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
  String? token;
  ///Once user is in homepage of the app they'll get permission request for Notification.
  @override
  void initState() {
    super.initState();
    getNotificationInitialized();
  }

  getNotificationInitialized() async{
    notificationService.requestNotificationPermission();
    token =  await notificationService.getDeviceToken();
    // if(token!.isNotEmpty){
    // notificationService.getRefreshToken();
    // }
    notificationService.foregroundNotification();
    notificationService.backgroundNotification(context);
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
