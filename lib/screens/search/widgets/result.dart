import 'dart:developer' as developer;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tv/model/movie/search.dart';
import 'package:flutter_tv/service/search.dart';
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
    // TODO: implement initState
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
      margin: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
      width: MediaQuery.of(context).size.width,
      height: (MediaQuery.of(context).size.height - 150).h,
      child: _movies.isEmpty
          ? GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(10),
                right: ScreenUtil().setWidth(10),
              ),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1.8,
              children: [1, 2, 3, 4].map((e) => _shimmer()).toList(),
            )
          : GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(10),
                right: ScreenUtil().setWidth(10),
              ),
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
      padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
      color: const Color(0xFFFFFFFF),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: movie.moviePic,
            width: 50.w,
            height: 200.h,
            fit: BoxFit.fitHeight,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Container(
            width: ((MediaQuery.of(context).size.width - 620) / 2).w,
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.movieName,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 10.sp),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(5))),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(2.5),
                        top: ScreenUtil().setWidth(1),
                        right: ScreenUtil().setWidth(2.5),
                        bottom: ScreenUtil().setWidth(1),
                      ),
                      margin: EdgeInsets.only(right: ScreenUtil().setWidth(5)),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1E1E1),
                        borderRadius: BorderRadius.circular(2).w,
                      ),
                      child: Text(
                        movie.movieClass,
                        style: TextStyle(
                            color: const Color(0xFF6D6D6D), fontSize: 6.sp),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(2.5),
                        top: ScreenUtil().setWidth(1),
                        right: ScreenUtil().setWidth(2.5),
                        bottom: ScreenUtil().setWidth(1),
                      ),
                      margin: EdgeInsets.only(right: ScreenUtil().setWidth(5)),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1E1E1),
                        borderRadius: BorderRadius.circular(2).w,
                      ),
                      child: Text(
                        movie.movieYear,
                        style: TextStyle(
                            color: const Color(0xFF6D6D6D), fontSize: 6.sp),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(2.5),
                        top: ScreenUtil().setWidth(1),
                        right: ScreenUtil().setWidth(2.5),
                        bottom: ScreenUtil().setWidth(1),
                      ),
                      margin: EdgeInsets.only(right: ScreenUtil().setWidth(5)),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1E1E1),
                        borderRadius: BorderRadius.circular(2).w,
                      ),
                      child: Text(
                        movie.movieSource,
                        style: TextStyle(
                            color: const Color(0xFF6D6D6D), fontSize: 6.sp),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(5))),
                Text.rich(
                  TextSpan(
                    text: "导演: ",
                    style: TextStyle(
                      color: const Color(0xFF797A7A),
                      fontSize: 6.5.sp,
                    ),
                    children: [
                      TextSpan(
                        text: movie.movieDirector,
                        style: TextStyle(
                          color: const Color(0xFF3C3C3C),
                          fontSize: 6.5.sp,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(5))),
                Text.rich(
                  TextSpan(
                    text: "主演: ",
                    style: TextStyle(
                      color: const Color(0xFF797A7A),
                      fontSize: 6.5.sp,
                    ),
                    children: [
                      TextSpan(
                        text: movie.movieStarring,
                        style: TextStyle(
                          color: const Color(0xFF3C3C3C),
                          fontSize: 6.5.sp,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(5))),
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
                    borderRadius: BorderRadius.circular(25).w,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/detail/$id-1-1/", (route) => false);
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
        padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
        color: const Color(0xFFFFFFFF),
      ),
    );
  }
}
