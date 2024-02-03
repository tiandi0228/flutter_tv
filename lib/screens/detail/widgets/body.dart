import 'package:flutter/material.dart';
import 'package:flutter_tv/screens/detail/widgets/episodes.dart';
import 'package:flutter_tv/screens/detail/widgets/testimonials.dart';
import 'package:flutter_tv/screens/detail/widgets/video.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height + 62,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Video(),
            Episodes(),
            Testimonials(),
          ],
        ),
      ),
    );
  }
}
