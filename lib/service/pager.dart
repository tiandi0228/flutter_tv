import 'dart:developer' as developer;

import 'package:flutter_tv/server/base.dart';
import 'package:html/parser.dart';

Future fetchSearchPager(String str, int page) async {
  int total = 1;

  try {
    var response =
        await httpApi.getString("vodsearch/-------------.html?wd=$str");
    var document = parse(response);
    total = int.parse(document
        .querySelectorAll('.page a.page-number.page-next')[1]
        .attributes['href']!
        .trim()
        .split('/')[2]
        .split('.')[0]
        .split('---')[3]
        .split('-')[1]);
    return total;
  } catch (e) {
    developer.log('$e', name: '搜索信息错误');
  }
  developer.log('$total', name: '分页总数');
  return total;
}
