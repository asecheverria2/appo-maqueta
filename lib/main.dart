import 'package:appo_lab/src/pages/menu_page.dart';
//import 'package:appo_lab/src/pages/secondscreen.dart';
import 'package:appo_lab/src/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:appo_lab/src/providers/main_provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:appo_lab/src/theme/main_theme.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

//import 'package:convex_bottom_bar/convex_bottom_bar.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
