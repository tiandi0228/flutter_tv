import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class Testimonials extends StatefulWidget {
  const Testimonials({super.key});

  @override
  State<Testimonials> createState() => _TestimonialsState();
}

class _TestimonialsState extends State<Testimonials> {
  final List<int> list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];

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
                  color: Color.fromRGBO(211, 211, 211, 1),
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
                children: list
                    .map(
                      (e) => InkWell(
                        onTap: () => {
                          developer.log('当前选择的视频: $e', name: '$e'),
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 80) / 5,
                          margin: EdgeInsets.only(
                              right:
                                  list.indexOf(e) + 1 == list.length ? 0 : 10),
                          color: Colors.blue,
                          child: Column(
                            children: [
                              Text('$e'),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
