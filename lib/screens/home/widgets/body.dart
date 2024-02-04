import 'package:flutter/material.dart';
import 'package:flutter_tv/screens/home/widgets/label.dart';
import 'package:flutter_tv/screens/home/widgets/search.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.zero,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Search(),
          Label(),
        ],
      ),
    );
  }
}
