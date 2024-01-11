import 'dart:io';

import 'package:chat_app2/Provider_Controller/ForgotProvider/forgot_provider.dart';
import 'package:chat_app2/Provider_Controller/ProfileProvider/profile_provider.dart';
import 'package:chat_app2/Provider_Controller/SignInProvider/sign_in_provider.dart';
import 'package:chat_app2/Provider_Controller/SingUpProvider/sign_up_provider.dart';
import 'package:chat_app2/Provider_Controller/SplashProvider/splash_provider.dart';
import 'package:chat_app2/Provider_Controller/UpdateProfile/update_profile_provider.dart';
import 'package:chat_app2/Views/SplashScreen/splash_screen1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'Provider_Controller/Messageprovider/messageProvider.dart';
late final String apiKey;
Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  await dotenv.load(fileName: "assets/.env");
  apiKey = dotenv.env['AIzaSyAJ9P_tKdhvOTdu92BF25Sv1mjqQiqXKGQ'] ?? '';
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MessageProvider()),
          ChangeNotifierProvider(create: (_) => SignUpProvider()),
          ChangeNotifierProvider(create: (_) => SingInProvider()),
          ChangeNotifierProvider(create: (_) => ForgotProvider()),
          ChangeNotifierProvider(create: (_) => ProfileProvider()),
          ChangeNotifierProvider(create: (_) => SplashProvider()),
          ChangeNotifierProvider(create: (_) => UpdateProfileProvider()),
        ],
        child: const MyApp(),
      ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',

          theme: ThemeData(
            fontFamily: 'Poppins',
            // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            // useMaterial3: true,
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}