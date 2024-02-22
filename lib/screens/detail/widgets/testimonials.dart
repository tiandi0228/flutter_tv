import 'dart:developer' as developer;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tv/model/movie/testimonials.dart';
import 'package:flutter_tv/service/testimonials.dart';
import 'package:flutter_tv/utils/platform_util.dart';
import 'package:shimmer/shimmer.dart';

class Testimonials extends StatefulWidget {
  final String id;

  const Testimonials({super.key, required this.id});

  @override
  State<Testimonials> createState() => _TestimonialsState();
}

class _TestimonialsState extends State<Testimonials> {
  final List<TestimonialsItem> _movies = [];

  bool isPhone = PlatformUtils.isAndroid || PlatformUtils.isIOS;

  @override
  void initState() {
    super.initState();
    fetchTestimonialMovie(widget.id).then((data) {
      setState(() {
        _movies.clear();
        _movies.addAll(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "为你推荐",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: isPhone ? 170.h : 230.h,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _movies.isEmpty
                  ? Container(
                      padding: EdgeInsets.only(
                        top: ScreenUtil().setWidth(5),
                        bottom: ScreenUtil().setWidth(5),
                      ),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        enabled: true,
                        child: Row(
                          children: [1, 2, 3, 4, 5].map(
                            (e) {
                              return Container(
                                width:
                                    (MediaQuery.of(context).size.width - 62) /
                                        5,
                                margin: EdgeInsets.only(right: e == 5 ? 0 : 10),
                                color: const Color(0xCCCCCCCC),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    )
                  : Row(
                      children: _movies.asMap().entries.map((e) {
                        int index = e.key;
                        return _item(_movies[index], index);
                      }).toList(),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(TestimonialsItem movie, int index) {
    String id = movie.movieUrl.split("/")[2].split(".")[0];
    String title = Uri.encodeComponent(movie.movieName);
    double width =
        (MediaQuery.of(context).size.width - (isPhone ? 34.w : 42.w)) /
            (isPhone ? 3 : 5);
    return InkWell(
      onTap: () => {
        Navigator.pushNamedAndRemoveUntil(
            context, "/detail/$id-1-1/$title", (route) => false),
        developer.log('当前选择的视频: $movie', name: 'detail'),
      },
      child: Container(
        width: width,
        margin: EdgeInsets.only(
            right: index + 1 == _movies.length ? 0 : ScreenUtil().setWidth(5)),
        color: const Color(0xCCCCCCCC),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: movie.moviePic,
              width: width,
              height: isPhone ? 120.h : 140.h,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Container(
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(5),
                top: ScreenUtil().setWidth(2.5),
                right: ScreenUtil().setWidth(5),
              ),
              height: isPhone ? 50.h : 63.h,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    movie.movieName,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: const Color(0xCC5B5B5B),
                      fontSize: 14,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(5))),
                  Text(
                    movie.movieText,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: const Color(0xCC717171),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
