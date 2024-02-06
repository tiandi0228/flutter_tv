import 'dart:developer' as developer;

import 'package:flutter_tv/model/movie/episode.dart';
import 'package:flutter_tv/server/base.dart';
import 'package:html/parser.dart';

Future fetchEpisodes(String id) async {
  List<EpisodesItem> pages = [];
  try {
    var response = await httpApi.getString("vodplay/$id.html");
    var document = parse(response);
    var content = document.querySelector(".scroll-content");
    var items = content?.querySelectorAll(".scroll-content>a");
    for (int i = 0; i < items!.length; i++) {
      EpisodesItem item = EpisodesItem(items[i].attributes['href']!.trim(),
          items[i].querySelector('span')!.text.trim());
      pages.add(item);
    }
    return pages;
  } catch (e) {
    developer.log('$e', name: '获取影片集数错误');
  }
  developer.log('$pages', name: '影片集数');
  return pages;
}
