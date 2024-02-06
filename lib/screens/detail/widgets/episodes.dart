import 'package:flutter/material.dart';
import 'package:flutter_tv/model/movie/episode.dart';
import 'dart:developer' as developer;

import 'package:flutter_tv/service/episodes.dart';

class Episodes extends StatefulWidget {
  const Episodes({super.key});

  @override
  State<Episodes> createState() => _EpisodesState();
}

class _EpisodesState extends State<Episodes> {
  final List<EpisodesItem> _episodes = [];

  @override
  void initState() {
    super.initState();
    fetchEpisodes().then((data) {
      setState(() {
        _episodes.clear();
        _episodes.addAll(data);
      });
    });
  }

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
            children: _episodes.map((e) => _item(e)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _item(EpisodesItem item) {
    return InkWell(
      onTap: () => {developer.log('当前集数：$item', name: 'detail')},
      child: Container(
        width: 80,
        height: 30,
        color: Colors.black,
        alignment: Alignment.center,
        child: Text(
          item.movieName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
