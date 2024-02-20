import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:flutter_tv/model/movie/label.dart';
import 'package:flutter_tv/service/label.dart';
import 'package:shimmer/shimmer.dart';

class Label extends StatefulWidget {
  const Label({super.key});

  @override
  State<Label> createState() => _LabelState();
}

class _LabelState extends State<Label> {
  static const List<MaterialColor> primaries = <MaterialColor>[
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.blueGrey,
  ];
  final List<LabelItem> _lists = [];

  @override
  void initState() {
    super.initState();
    fetchLabel().then((data) {
      setState(() {
        _lists.clear();
        _lists.addAll(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      padding: EdgeInsets.zero,
      child: _lists.isEmpty ? _shimmer() : _item(),
    );
  }

  Widget _item() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: _lists.map((item) {
        String id = item.movieUrl.split("/")[2].split(".")[0];
        return InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            developer.log('$item', name: '电影名');
            Navigator.pushNamedAndRemoveUntil(
                context, "/detail/$id-1-1", (route) => false);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding:
                const EdgeInsets.only(left: 10, top: 2, right: 10, bottom: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: primaries[Random().nextInt(17)],
            ),
            child: Text(
              item.movieName,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      }).toList(),
    );
  }

  // 骨架
  Widget _shimmer() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((item) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: Container(
            width: 80,
            height: 24,
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: const Color(0xFF7C7C7C),
            ),
          ),
        );
      }).toList(),
    );
  }
}
