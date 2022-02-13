//import 'package:appo_lab/src/pages/usuario_page.dart';
import 'package:appo_lab/src/widgets/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:appo_lab/src/providers/main_provider.dart';
import 'package:provider/provider.dart';
import 'package:appo_lab/src/theme/main_theme.dart';
import 'src/pages/home_page.dart';

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
    return FutureBuilder<bool>(
      future: mainProvider.getPreferences(),
      builder: (context, snapshot) 
      {
        if(snapshot.hasData){
          return ScreenUtilInit(
                designSize: const Size(360, 690),
                builder: () => MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Flutter Demo',
                    theme: AppTheme.themeData(mainProvider.mode),
                    home: Login(),
                    ));
        }
        return const SizedBox.square(
              dimension: 100.0, child: CircularProgressIndicator());
      });
  }
}
