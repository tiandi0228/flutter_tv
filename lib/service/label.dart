import 'package:flutter_tv/model/movie/label.dart';
import 'dart:developer' as developer;

import 'package:flutter_tv/server/base.dart';
import 'package:html/parser.dart';

Future fetchLabel() async {
  List<LabelItem> labels = [];

  try {
    var response = await httpApi.getString("label/top.html");
    var document = parse(response);
    var content = document.querySelector(".list");
    var lists = content!.querySelectorAll('.list-item');
    var items = lists[0].querySelectorAll('a');
    for (var i = 0; i < items.length; i++) {
      LabelItem item = LabelItem(
          items[i].querySelector('span.keyword')!.text.trim(),
          items[i].attributes['href']!.trim());
      labels.add(item);
    }
    return labels;
  } catch (e) {
    developer.log('$e', name: '获取首页影片错误');
  }
  developer.log('$labels', name: '首页影片');
  return labels;
}
