//import 'package:findee/categories/lost_documents.dart';
//import 'package:findee/categories/lost_electronics.dart';
//import 'package:findee/categories/other_valuables.dart';
import 'package:findee/dashboard.dart';
import 'package:findee/categoryPage.dart';
import 'package:findee/login.dart';
import 'package:findee/providers/ads_provider.dart';
import 'package:findee/providers/category_provider.dart';
import 'package:findee/register.dart';
import 'package:findee/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:findee/constants.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider<AdsProvider>(
          create: (context) => AdsProvider(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'findee',
        theme: ThemeData(
          fontFamily: "Cairo",
          scaffoldBackgroundColor: kBackgroundColor,
          textTheme: Theme
              .of(context)
              .textTheme
              .apply(displayColor: kTextColor),
        ),
        //home: HomeScreen(),
          initialRoute: 'splashScreen',
        routes: {
          'home': (context)=>HomeScreen(),
          'login': (context)=>MyLogin(),
          'register': (context)=>MyRegister(),
          'dashboard': (context)=>MyDashboard(),
          'splashScreen' : (context) => SplashScreen(),
        },
      ),
    );
  }


}
