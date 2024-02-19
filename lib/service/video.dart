import 'dart:developer' as developer;

import 'package:flutter_tv/server/base.dart';
import 'package:html/parser.dart';

Future fetchVideo(String id) async {
  RegExp regex = RegExp((r'"url":"[^\s]+'));
  String str = "";
  try {
    var response = await httpApi.getString("vodplay/$id.html");
    var document = parse(response);
    var content = document.body!.text.trim();
    var url = regex.stringMatch(content)!.split(',')[0];

    str = url.substring(7, url.length - 1).replaceAll(RegExp("\\\\"), "");
    return str;
  } catch (e) {
    developer.log('$e', name: '获取影片错误');
  }

  return str;
}
