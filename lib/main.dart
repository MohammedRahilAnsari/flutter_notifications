import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification/screens/home_screen.dart';


///This is called top level function which runs when app is in background state
///The @pragma annotation help to define function type
///vm = virtual machine
///This will generate isolates for background notification
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  ///inside this function we have to initialize firebase instance to make it active even if app is in background state
  await Firebase.initializeApp();
}

void main() async{
  ///First we have to initialize widget binding
  WidgetsFlutterBinding.ensureInitialized();

  ///Initialize firebase and make this function async
  await Firebase.initializeApp();

  ///This is to define background handler function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // FirebaseMessaging.onMessageOpenedApp.listen((event) { print('app is open');});
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notification Reference',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
