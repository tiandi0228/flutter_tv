import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tv/router/router_handler.dart';
import 'dart:developer' as developer;

class MyRouter {
  static FluroRouter router = FluroRouter();
  static String splashPage = '/splash'; // 首屏
  static String homeScreen = '/home'; // 首页
  static String detailScreen = '/detail/:id'; // 详情
  static String searchScreen = '/search/:wd'; // 搜索

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      developer.log("ROUTE WAS NOT FOUND !!!");
      return;
    });
    router.define(homeScreen,
        handler: homeScreenHandler, transitionType: TransitionType.inFromLeft);
    router.define(detailScreen,
        handler: detailScreenHandler,
        transitionType: TransitionType.inFromLeft);
    router.define(searchScreen,
        handler: searchScreenHandler,
        transitionType: TransitionType.inFromLeft);
  }
}
