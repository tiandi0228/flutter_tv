import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(0),
        child: InkWell(
          onTap: () => {Navigator.pushNamed(context, '/detail')},
          child: const Text("快点我"),
        ),
      ),
    );
  }
}
