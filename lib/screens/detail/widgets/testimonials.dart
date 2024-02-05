import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tv/model/movie/movie.dart';
import 'dart:developer' as developer;

import 'package:flutter_tv/service/testimonials.dart';

class Testimonials extends StatefulWidget {
  const Testimonials({super.key});

  @override
  State<Testimonials> createState() => _TestimonialsState();
}

class _TestimonialsState extends State<Testimonials> {
  final List<MovieItem> _movies = [];

  @override
  void initState() {
    super.initState();
    fetchTestimonialMovie().then((data) {
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
              ),
              Text(
                '请左右滑动',
                style: TextStyle(
                  color: Color(0xFF8F8F8F),
                  fontSize: 14,
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
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

  Widget _item(MovieItem movie, int index) {
    return InkWell(
      onTap: () => {
        developer.log('当前选择的视频: $movie', name: 'detail'),
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 62) / 5,
        margin: EdgeInsets.only(right: index + 1 == _movies.length ? 0 : 10),
        color: const Color(0xCCCCCCCC),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: movie.moviePic,
              width: (MediaQuery.of(context).size.width - 62) / 5,
              height: 150,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
              height: 45,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    movie.movieName,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Color(0xCC5B5B5B),
                      fontSize: 12,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  Text(
                    movie.movieText,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Color(0xCC717171),
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
