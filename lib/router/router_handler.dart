import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tv/screens/detail/detail_screen.dart';
import 'package:flutter_tv/screens/home/home_screen.dart';
import 'package:flutter_tv/screens/search/search_screen.dart';

// 首页
var homeScreenHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const HomeScreen();
});

// 详情
var detailScreenHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String? id = params["id"]?.first;
  return DetailScreen(id: id ?? "");
});

// 搜索
var searchScreenHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String? wd = params["wd"]?.first;
  return SearchScreen(wd: wd ?? "");
});
