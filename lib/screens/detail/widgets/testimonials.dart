import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class Testimonials extends StatefulWidget {
  const Testimonials({super.key});

  @override
  State<Testimonials> createState() => _TestimonialsState();
}

class _TestimonialsState extends State<Testimonials> {
  final List<String> lists = [
    '三大队',
    '仙剑四',
    '龙珠超',
    '钢铁侠',
    '超人前传',
    '三大队',
    '仙剑四',
    '龙珠超',
    '钢铁侠',
    '超人前传',
    '三大队',
    '仙剑四',
    '龙珠超',
    '钢铁侠',
    '超人前传'
  ];

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
                children: lists.asMap().entries.map((e) {
                  String item = e.value;
                  int index = e.key;
                  return InkWell(
                    onTap: () => {
                      developer.log('当前选择的视频: $item', name: 'detail'),
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 62) / 5,
                      margin: EdgeInsets.only(
                          right: index + 1 == lists.length ? 0 : 10),
                      color: const Color(0xCCCCCCCC),
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                'https://picsum.photos/250?image=${index + 1}',
                            height: 150,
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 10, top: 5, right: 10),
                            height: 45,
                            alignment: Alignment.center,
                            child: Text(
                              item,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                color: Color(0xCC5B5B5B),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
