import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tv/constants.dart';
import 'package:flutter_tv/router/router.dart';
import 'package:flutter_tv/screens/splash/splash_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(const MainApp());
  MyRouter.configureRoutes(MyRouter.router);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '电影网',
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
      ),
      onGenerateRoute: MyRouter.router.generator,
      home: const SplashScreen(),
    );
  }
}