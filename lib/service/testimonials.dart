import 'package:flutter_tv/model/movie/movie.dart';
import 'package:flutter_tv/server/base.dart';
import 'package:html/parser.dart';
import 'dart:developer' as developer;

Future fetchTestimonialMovie() async {
  List<MovieItem> movies = [];
  try {
    var response = await httpApi.getString("vodplay/591-1-8.html");
    var document = parse(response);
    var content = document.querySelector(".module-items");
    var items = content?.querySelectorAll(".module-item");
    for (int i = 0; i < items!.length; i++) {
      MovieItem item = MovieItem(
        items[i].querySelector('.video-name>a')!.text.trim(), // 获取影片名
        items[i]
            .querySelector('.module-item-pic>img')!
            .attributes['data-src']!
            .trim(), // 获取缩略图
        items[i].querySelector('.module-item-text')!.text.trim(), // 获取影片当前的集数
        items[i]
            .querySelector('.module-item-pic>a')!
            .attributes['href']!
            .trim(), // 获取影片地址
        items[i].querySelectorAll('.module-item-caption>span')[0].text.trim(),
        items[i].querySelectorAll('.module-item-caption>span')[1].text.trim(),
        items[i].querySelectorAll('.module-item-caption>span')[2].text.trim(),
      );
      movies.add(item);
    }
    return movies;
  } catch (e) {
    developer.log('$e', name: '获取推荐影片错误');
  }
  developer.log('$movies', name: '影片');
  return movies;
}
