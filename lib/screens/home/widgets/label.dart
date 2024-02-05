import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:developer' as developer;

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
  static List<String> lists = [
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
      width: MediaQuery.of(context).size.width / 1.5,
      padding: EdgeInsets.zero,
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: lists
            .map(
              (e) => InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  developer.log(e, name: '电影名');
                  Navigator.pushNamed(context, '/detail/1');
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(
                      left: 10, top: 2, right: 10, bottom: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: primaries[Random().nextInt(17)],
                  ),
                  child: Text(
                    e,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
