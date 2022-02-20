import 'package:appo_lab/src/pages/menu_page.dart';
//import 'package:appo_lab/src/pages/secondscreen.dart';
import 'package:appo_lab/src/widgets/login_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:appo_lab/src/providers/main_provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:appo_lab/src/theme/main_theme.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:developer' as developer;

//import 'package:convex_bottom_bar/convex_bottom_bar.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  developer.log('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAT3oW9nqeVRmGv-PoetVzZONVTdHYJ0dc',
      appId: '1:450553040977:android:acaeda1abde1339f192870',
      messagingSenderId: '450553040977',
      projectId: 'appo-lab',
    ),
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage? value) => developer.log(value.toString())
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //print('A new onMessage event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: 'app_icon',
              ),
            ));
      }

      //print(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      developer.log('A new onMessageOpenedApp event was published!');
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    mainProvider.getPreferences();

    Widget example1 = SplashScreenView(
      navigateRoute: const Login(),
      duration: 5000,
      imageSize: 200,
      imageSrc: "assets/images/microscopio.png",
      text: "APPO-LAB",
      textType: TextType.ColorizeAnimationText,
      textStyle: const TextStyle(
        fontSize: 40.0,
      ),
      colors: const [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: const Color(0xFF102639),
    );
    
    Widget example2 = SplashScreenView(
      navigateRoute: const MenuPage(),
      duration: 5000,
      imageSize: 200,
      imageSrc: "assets/images/microscopio.png",
      text: "APPO-LAB",
      textType: TextType.ColorizeAnimationText,
      textStyle: const TextStyle(
        fontSize: 40.0,
      ),
      colors: const [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: const Color(0xFF102639),
    );
    return FutureBuilder<bool>(
      future: mainProvider.getPreferences(),
      builder: (context, snapshot) 
      {
        if(snapshot.hasData){
          return ScreenUtilInit(
                //designSize: const Size(690, 690),
                builder: () => MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Flutter Demo',
                    theme: AppTheme.themeData(mainProvider.mode),
                    home: //example1
                      mainProvider.token == ""
                        ? example1
                        : JwtDecoder.isExpired(mainProvider.token)
                            ? example1
                            : example2,
                  )
          );
        }
        return const SizedBox.square(
              dimension: 100.0, child: CircularProgressIndicator());
      });
  }
}
