import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tv/model/movie/episode.dart';
import 'package:flutter_tv/model/movie/movie.dart';
import 'package:flutter_tv/service/episodes.dart';
import 'package:flutter_tv/service/movie.dart';
import 'package:shimmer/shimmer.dart';

class Episodes extends StatefulWidget {
  final String id;

  const Episodes({super.key, required this.id});

  @override
  State<Episodes> createState() => _EpisodesState();
}

class _EpisodesState extends State<Episodes> {
  final List<EpisodesItem> _episodes = [];
  var _movie = Movie("", "", "", "", "");

  @override
  void initState() {
    super.initState();
    fetchMovie(widget.id).then((data) {
      setState(() {
        _movie = data;
      });
    });
    fetchEpisodes(widget.id).then((data) {
      setState(() {
        _episodes.clear();
        _episodes.addAll(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _info(_movie),
          Padding(padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(5))),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
            child: const Text(
              '选集',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          _item()
        ],
      ),
    );
  }

  // 基本信息
  Widget _info(Movie movie) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        movie.movieName.isEmpty
            ? _shimmer()
            : Text(
                movie.movieName,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
        const Padding(padding: EdgeInsets.only(top: 5)),
        Row(
          children: [
            movie.moviePage.isEmpty
                ? _shimmer()
                : Container(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(8),
                      top: ScreenUtil().setWidth(3),
                      right: ScreenUtil().setWidth(8),
                      bottom: ScreenUtil().setWidth(3),
                    ),
                    color: const Color(0xFF7C7C7C),
                    alignment: Alignment.center,
                    child: Text(
                      movie.moviePage,
                      style: const TextStyle(
                        color: Color(0xFFE1E1E1),
                        fontSize: 16,
                      ),
                    ),
                  ),
            Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(5))),
            movie.movieClass.isEmpty
                ? _shimmer()
                : Container(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(8),
                      top: ScreenUtil().setWidth(3),
                      right: ScreenUtil().setWidth(8),
                      bottom: ScreenUtil().setWidth(3),
                    ),
                    color: const Color(0xFF7C7C7C),
                    alignment: Alignment.center,
                    child: Text(
                      movie.movieClass,
                      style: const TextStyle(
                        color: Color(0xFFE1E1E1),
                        fontSize: 16,
                      ),
                    ),
                  ),
            Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(5))),
            movie.movieYear.isEmpty
                ? _shimmer()
                : Container(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(8),
                      top: ScreenUtil().setWidth(3),
                      right: ScreenUtil().setWidth(8),
                      bottom: ScreenUtil().setWidth(3),
                    ),
                    color: const Color(0xFF7C7C7C),
                    alignment: Alignment.center,
                    child: Text(
                      movie.movieYear,
                      style: const TextStyle(
                        color: Color(0xFFE1E1E1),
                        fontSize: 16,
                      ),
                    ),
                  ),
            Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(5))),
            movie.movieSource.isEmpty
                ? _shimmer()
                : Container(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(8),
                      top: ScreenUtil().setWidth(3),
                      right: ScreenUtil().setWidth(8),
                      bottom: ScreenUtil().setWidth(3),
                    ),
                    color: const Color(0xFF7C7C7C),
                    alignment: Alignment.center,
                    child: Text(
                      movie.movieSource,
                      style: const TextStyle(
                        color: Color(0xFFE1E1E1),
                        fontSize: 16,
                      ),
                    ),
                  ),
          ],
        ),
      ],
    );
  }

  // 集数
  Widget _item() {
    return _episodes.isEmpty
        ? Container(
            padding: EdgeInsets.only(
                top: ScreenUtil().setWidth(5),
                bottom: ScreenUtil().setWidth(5)),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [1, 1, 1, 1, 1, 1, 1, 1].map((e) {
                  return _shimmer();
                }).toList(),
              ),
            ),
          )
        : Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _episodes.map(
              (item) {
                String id = item.movieUrl.split("/")[2].split(".")[0];
                return InkWell(
                  onTap: () => {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/detail/$id", (route) => false),
                    developer.log('当前集数：$item', name: 'detail'),
                  },
                  child: Container(
                    width: 72,
                    height: 30,
                    color: widget.id == id ? Colors.blue : Colors.black,
                    alignment: Alignment.center,
                    child: Text(
                      item.movieName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          );
  }

  // 骨架
  Widget _shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        width: 72,
        height: 30,
        color: const Color(0xFF7C7C7C),
      ),
    );
  }
}
