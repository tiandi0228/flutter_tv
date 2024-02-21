import 'package:flutter/material.dart';
import 'package:flutter_tv/screens/detail/widgets/episodes.dart';
import 'package:flutter_tv/screens/detail/widgets/search.dart';
import 'package:flutter_tv/screens/detail/widgets/testimonials.dart';
import 'package:flutter_tv/screens/detail/widgets/video.dart';
import 'dart:developer' as developer;

import 'package:flutter_tv/utils/window_util.dart';

class Body extends StatefulWidget {
  final String id;
  const Body({super.key, required this.id});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String id;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      id = widget.id;
    });
    developer.log(id, name: "id");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildSearch(),
            VideoPlay(
              id: id,
              onChangeFullScreen: (value) {
                setState(() {
                  _isFullScreen = value;
                });
              },
            ),
            if (!_isFullScreen) Episodes(id: id),
            if (!_isFullScreen) Testimonials(id: id),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Offstage(
      offstage: _isFullScreen,
      child: Container(
        height: 60,
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Container(
              height: 40,
              padding: const EdgeInsets.only(left: 10, right: 20),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/home", (route) => false);
                },
              ),
            ),
            const Search(),
          ],
        ),
      ),
    );
  }
}
