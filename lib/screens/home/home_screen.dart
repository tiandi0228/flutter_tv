import 'package:flutter/material.dart';
import 'package:flutter_tv/screens/home/widgets/body.dart';
import 'package:flutter_tv/utils/platform_util.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (!PlatformUtils.isMacOS && !PlatformUtils.isWindows)
          ? AppBar(
              backgroundColor: Colors.black,
              title: const Text(
                '首页',
                style: TextStyle(color: Colors.white),
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  tooltip: "Search",
                  onPressed: () {
                    Navigator.pushNamed(context, "/search/");
                  },
                ),
              ],
            )
          : null,
      body: const Body(),
    );
  }
}
