import 'dart:developer' as developer;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tv/config/constants.dart';
import 'package:flutter_tv/model/movie/search.dart';
import 'package:flutter_tv/screens/home/widgets/search_data.dart';
import 'package:flutter_tv/service/pager.dart';
import 'package:flutter_tv/service/search.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class PhoneResult extends StatefulWidget {
  const PhoneResult({super.key});

  @override
  State<PhoneResult> createState() => _PhoneResultState();
}

class _PhoneResultState extends State<PhoneResult> {
  List<SearchMovie> _movies = [];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  // 页码
  int _page = 1;

  // 关键字
  String _keyword = "";

  // 总页数
  int _totalPage = 1;

  bool _loading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    setState(() {
      _keyword = SearchDataWidget.of(context)!.data;
    });
    if (_keyword.isEmpty) return;
    getPage();
    getData(1);
  }

  // 获取总页数
  void getPage() {
    fetchSearchPager(_keyword, 1).then((data) {
      setState(() {
        _totalPage = data;
      });
    });
  }

  // 获取数据
  void getData(int page) {
    setState(() {
      _loading = true;
    });

    fetchSearch(_keyword, page).then((data) {
      setState(() {
        _movies.clear();
        _movies.addAll(data);
        _loading = false;
      });
    });
  }

  // 下拉刷新
  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      _page = 1;
    });
    getData(1);
    _refreshController.refreshCompleted();
    _refreshController.resetNoData();
  }

  // 上拉加载
  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      _page = _page + 1;
    });
    if (_page >= _totalPage) {
      _refreshController.loadNoData();
    } else {
      fetchSearch(_keyword, _page).then((data) {
        setState(() {
          _movies += data;
        });
      });
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            children: [1, 2, 3, 4, 5, 6].map((e) {
          return Column(
            children: [
              Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(10))),
              _shimmer(),
            ],
          );
        }).toList()),
      );
    }

    // 空数据
    if (_movies.isEmpty) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        child: const Text(
          '暂无数据',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const WaterDropHeader(),
        footer: const ClassicFooter(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, i) => InkWell(
            onTap: () {
              String id = _movies[i].movieUrl.split("/")[2].split(".")[0];
              String title = Uri.encodeComponent(_movies[i].movieName);
              Navigator.pushNamedAndRemoveUntil(
                  context, "/detail/$id-1-1/$title", (route) => false);
              developer.log(_movies[i].movieName, name: 'search');
            },
            child: Card(
              color: cardBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: _movies[i].moviePic,
                        width: 100,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Container(
                      width: 200,
                      margin: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _movies[i].movieName,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 5)),
                          Text.rich(
                            TextSpan(
                              text: "导演: ",
                              style: const TextStyle(
                                color: Color(0xFF797A7A),
                                fontSize: 12,
                              ),
                              children: [
                                TextSpan(
                                  text: _movies[i].movieDirector,
                                  style: const TextStyle(
                                    color: Color(0xFF797A7A),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Padding(padding: EdgeInsets.only(top: 5)),
                          Text.rich(
                            TextSpan(
                              text: "主演: ",
                              style: const TextStyle(
                                color: Color(0xFF797A7A),
                                fontSize: 12,
                              ),
                              children: [
                                TextSpan(
                                  text: _movies[i].movieStarring,
                                  style: const TextStyle(
                                    color: Color(0xFF797A7A),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          _buildTag(_movies[i]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          itemExtent: 130.0,
          itemCount: _movies.length,
        ),
      ),
    );
  }

  // 电影标签
  Widget _buildTag(SearchMovie movie) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 5,
            top: 2,
            right: 5,
            bottom: 2,
          ),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFE1E1E1),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            movie.movieClass,
            style: const TextStyle(color: Color(0xFF6D6D6D), fontSize: 12),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 5,
            top: 2,
            right: 5,
            bottom: 2,
          ),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFE1E1E1),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            movie.movieYear,
            style: const TextStyle(color: Color(0xFF6D6D6D), fontSize: 12),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 5,
            top: 2,
            right: 5,
            bottom: 2,
          ),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFE1E1E1),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            movie.movieSource,
            style: const TextStyle(color: Color(0xFF6D6D6D), fontSize: 12),
          ),
        ),
      ],
    );
  }

  // 骨架
  Widget _shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(10),
          right: ScreenUtil().setWidth(10),
        ),
        padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
        child: Row(
          children: [
            Container(
              width: 100.w,
              height: 110.h,
              padding: EdgeInsets.zero,
              color: const Color(0xFF7C7C7C),
            ),
            Container(
              width: 200.w,
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 20.h,
                    padding: EdgeInsets.zero,
                    color: const Color(0xFF7C7C7C),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(5))),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 20.h,
                    padding: EdgeInsets.zero,
                    color: const Color(0xFF7C7C7C),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(5))),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 20.h,
                    padding: EdgeInsets.zero,
                    color: const Color(0xFF7C7C7C),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(10))),
                  Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 20.h,
                        padding: EdgeInsets.zero,
                        color: const Color(0xFF7C7C7C),
                      ),
                      Container(
                        width: 40.w,
                        height: 20.h,
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.only(left: ScreenUtil().setWidth(5)),
                        color: const Color(0xFF7C7C7C),
                      ),
                      Container(
                        width: 40.w,
                        height: 20.h,
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.only(left: ScreenUtil().setWidth(5)),
                        color: const Color(0xFF7C7C7C),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
