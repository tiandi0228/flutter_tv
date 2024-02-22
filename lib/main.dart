import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tv/config/constants.dart';
import 'package:flutter_tv/router/router.dart';
import 'package:flutter_tv/screens/splash/splash_screen.dart';
import 'package:flutter_tv/utils/window_util.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  WindowUtil.init(800, 600);
  WindowUtil.setResizable(false);
  WindowUtil.setFullScreen(false);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  MyRouter.configureRoutes(MyRouter.router);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        ScreenUtil.init(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '电影网',
          theme: ThemeData(
            scaffoldBackgroundColor: backgroundColor,
          ),
          onGenerateRoute: MyRouter.router.generator,
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
