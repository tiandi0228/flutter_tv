import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tv/model/movie/search.dart';
import 'package:flutter_tv/service/search.dart';
import 'dart:developer' as developer;

import 'package:shimmer/shimmer.dart';

class Result extends StatefulWidget {
  final String wd;
  final int page;
  const Result({super.key, required this.wd, required this.page});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final List<SearchMovie> _movies = [];

  @override
  void initState() {
    super.initState();
    fetchSearch(widget.wd, widget.page).then((data) {
      setState(() {
        _movies.clear();
        _movies.addAll(data);
      });
    });
  }

  // 更新上级组件传参的变化
  @override
  void didUpdateWidget(covariant Result oldWidget) {
    super.didUpdateWidget(oldWidget);
    fetchSearch(widget.wd, widget.page).then((data) {
      setState(() {
        _movies.clear();
        _movies.addAll(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 210,
      child: _movies.isEmpty
          ? GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.only(left: 20, right: 20),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1.8,
              children: [1, 2, 3, 4].map((e) => _shimmer()).toList(),
            )
          : GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.only(left: 20, right: 20),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1.8,
              children: _movies.map((e) => _buildItem(e)).toList(),
            ),
    );
  }

  Widget _buildItem(SearchMovie movie) {
    String id = movie.movieUrl.split("/")[2].split(".")[0];
    return Container(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(10),
      color: const Color(0xFFFFFFFF),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: movie.moviePic,
            width: 120,
            height: 200,
            fit: BoxFit.fitHeight,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 380) / 2,
            margin: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.movieName,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 20),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 5, top: 2, right: 5, bottom: 2),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1E1E1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        movie.movieClass,
                        style: const TextStyle(
                            color: Color(0xFF6D6D6D), fontSize: 12),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 5, top: 2, right: 5, bottom: 2),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1E1E1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        movie.movieYear,
                        style: const TextStyle(
                            color: Color(0xFF6D6D6D), fontSize: 12),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 5, top: 2, right: 5, bottom: 2),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1E1E1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        movie.movieSource,
                        style: const TextStyle(
                            color: Color(0xFF6D6D6D), fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Text.rich(
                  TextSpan(
                    text: "导演: ",
                    style: const TextStyle(
                      color: Color(0xFF797A7A),
                      fontSize: 13,
                    ),
                    children: [
                      TextSpan(
                        text: movie.movieDirector,
                        style: const TextStyle(
                          color: Color(0xFF3C3C3C),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Text.rich(
                  TextSpan(
                    text: "主演: ",
                    style: const TextStyle(
                      color: Color(0xFF797A7A),
                      fontSize: 13,
                    ),
                    children: [
                      TextSpan(
                        text: movie.movieStarring,
                        style: const TextStyle(
                          color: Color(0xFF3C3C3C),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  margin: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFE952E),
                        Color(0xFFFE6229),
                        Color(0xFFFF4D43),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/detail/$id-1-1", (route) => false);
                      developer.log(movie.movieName, name: 'search');
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: const Text(
                      '在线观看',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 骨架
  Widget _shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.all(10),
        color: const Color(0xFFFFFFFF),
      ),
    );
  }
}
