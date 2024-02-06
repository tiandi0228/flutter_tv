import 'package:flutter/material.dart';
import 'package:flutter_tv/model/movie/episode.dart';
import 'package:flutter_tv/model/movie/movie.dart';
import 'dart:developer' as developer;

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
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(bottom: 10),
            child: const Text(
              '选集',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
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
      children: [
        Row(
          children: [
            movie.movieName.isEmpty
                ? _shimmer()
                : Text(
                    movie.movieName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
            const Padding(padding: EdgeInsets.only(left: 10)),
            movie.moviePage.isEmpty
                ? _shimmer()
                : Text(
                    movie.moviePage,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Row(
          children: [
            movie.movieClass.isEmpty
                ? _shimmer()
                : Container(
                    width: 80,
                    height: 30,
                    color: const Color(0xFF7C7C7C),
                    alignment: Alignment.center,
                    child: Text(
                      movie.movieClass,
                      style: const TextStyle(color: Color(0xFFE1E1E1)),
                    ),
                  ),
            const Padding(padding: EdgeInsets.only(left: 10)),
            movie.movieYear.isEmpty
                ? _shimmer()
                : Container(
                    width: 80,
                    height: 30,
                    color: const Color(0xFF7C7C7C),
                    alignment: Alignment.center,
                    child: Text(
                      movie.movieYear,
                      style: const TextStyle(color: Color(0xFFE1E1E1)),
                    ),
                  ),
            const Padding(padding: EdgeInsets.only(left: 10)),
            movie.movieSource.isEmpty
                ? _shimmer()
                : Container(
                    width: 80,
                    height: 30,
                    color: const Color(0xFF7C7C7C),
                    alignment: Alignment.center,
                    child: Text(
                      movie.movieSource,
                      style: const TextStyle(color: Color(0xFFE1E1E1)),
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
            padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                    Navigator.pushNamed(context, '/detail/$id'),
                    developer.log('当前集数：$item', name: 'detail'),
                  },
                  child: Container(
                    width: 80,
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
        width: 80,
        height: 30,
        color: const Color(0xFF7C7C7C),
      ),
    );
  }
}
