import 'dart:developer' as developer;

import 'package:flutter_tv/model/movie/search.dart';
import 'package:flutter_tv/server/base.dart';
import 'package:html/parser.dart';

Future fetchSearch(String str, int page) async {
  List<SearchMovie> movies = [];

  try {
    var response =
        await httpApi.getString("vodsearch/$str----------$page---.html");
    var document = parse(response);
    var items = document.querySelectorAll(
        '.module .module-list .module-items .module-search-item');
    for (var i = 0; i < items.length; i++) {
      List<String> directorsTemp = [];
      List<String> starringTemp = [];
      var directors = items[i]
          .querySelectorAll('.video-info-items')[0]
          .querySelectorAll('.video-info-actor>a');
      for (var i = 0; i < directors.length; i++) {
        directorsTemp.add(directors[i].text.trim());
      }
      var starlings = items[i]
          .querySelectorAll('.video-info-items')[1]
          .querySelectorAll('.video-info-actor>a');
      for (var i = 0; i < starlings.length; i++) {
        starringTemp.add(starlings[i].text.trim());
      }
      SearchMovie item = SearchMovie(
          items[i]
              .querySelector('.module-item-pic>img')!
              .attributes['data-src']!
              .trim(), // 缩略图
          items[i]
              .querySelector('.module-item-pic>img')!
              .attributes['alt']!
              .trim(), // 名称
          items[i]
              .querySelectorAll('.video-info-aux>a.tag-link')[0]
              .text
              .trim(), // 分类
          items[i]
              .querySelectorAll('.video-info-aux>div>a')[0]
              .text
              .trim(), // 年份
          items[i]
              .querySelectorAll('.video-info-aux>div>a')[1]
              .text
              .trim(), // 产地
          directorsTemp.join(' / '), // 导演
          starringTemp.join(' / '), // 主演
          items[i].querySelector('.video-serial')!.text.trim(), // 更新状态
          items[i]
              .querySelector('.module-item-pic>a')!
              .attributes['href']!
              .trim() // 地址
          );
      movies.add(item);
    }

    return movies;
  } catch (e) {
    developer.log('$e', name: '搜索信息错误');
  }
  developer.log('$movies', name: '搜索结果');
  return movies;
}
