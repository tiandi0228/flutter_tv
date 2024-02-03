import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class Episodes extends StatefulWidget {
  const Episodes({super.key});

  @override
  State<Episodes> createState() => _EpisodesState();
}

class _EpisodesState extends State<Episodes> {
  static List<int> episodes = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(bottom: 10),
                child: const Text(
                  '三大队',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: const Text(
                  '第五集',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
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
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: episodes
                .map(
                  (e) => InkWell(
                    onTap: () => {developer.log('当前集数：$e', name: 'detail')},
                    child: Container(
                      width: 30,
                      height: 30,
                      color: Colors.black,
                      alignment: Alignment.center,
                      child: Text(
                        '$e',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          // GridView.count(
          //   crossAxisCount: 12,
          //   shrinkWrap: true,
          //   mainAxisSpacing: 5,
          //   crossAxisSpacing: 5,
          //   childAspectRatio: 3,
          //   padding: EdgeInsets.zero,
          //   children: episodes
          //       .map(
          //         (e) => InkWell(
          //           onTap: () => {developer.log('当前集数：$e', name: 'detail')},
          //           child: Container(
          //             color: Colors.black,
          //             alignment: Alignment.center,
          //             child: Text(
          //               '$e',
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: MediaQuery.of(context).size.width / 80,
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          //       .toList(),
          // ),
        ],
      ),
    );
  }
}
