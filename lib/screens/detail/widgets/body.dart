import 'package:flutter/material.dart';
import 'package:flutter_tv/screens/detail/widgets/episodes.dart';
import 'package:flutter_tv/screens/detail/widgets/testimonials.dart';
import 'package:flutter_tv/screens/detail/widgets/video.dart';
import 'dart:developer' as developer;

class Body extends StatefulWidget {
  final String id;
  const Body({super.key, required this.id});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    developer.log(widget.id, name: "id");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 10),
      child: const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            VideoPlay(),
            Episodes(),
            Testimonials(),
          ],
        ),
      ),
    );
  }
}
