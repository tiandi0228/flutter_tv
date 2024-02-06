import 'package:flutter_tv/model/movie/movie.dart';
import 'dart:developer' as developer;

import 'package:flutter_tv/server/base.dart';
import 'package:html/parser.dart';

Future fetchMovie(String id) async {
  var movie = Movie("", "", "", "", "");

  try {
    var response = await httpApi.getString("vodplay/$id.html");
    var document = parse(response);
    var content = document.querySelector(".video-info");
    movie.movieName = content!.querySelector(".page-title>a")!.text.trim();
    movie.moviePage = content.querySelector('.btn-pc.page-title')!.text.trim();
    var items = content.querySelectorAll('.video-info-aux>a.tag-link');
    movie.movieClass = items[0].text.trim();
    movie.movieYear = items[1].text.trim();
    movie.movieSource = items[2].text.trim();
    return movie;
  } catch (e) {
    developer.log('$e', name: '获取影片信息错误');
  }
  developer.log('$movie', name: '影片信息');
  return movie;
}
