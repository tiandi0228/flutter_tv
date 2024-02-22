import 'package:flutter/material.dart';
import 'package:flutter_tv/screens/detail/widgets/body.dart';
import 'package:flutter_tv/utils/platform_util.dart';

class DetailScreen extends StatelessWidget {
  final String id;
  final String title;

  const DetailScreen({super.key, required this.id, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: (!PlatformUtils.isMacOS && !PlatformUtils.isWindows)
            ? AppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/home", (route) => false);
                  },
                ),
                backgroundColor: Colors.black,
                title: Text(
                  Uri.decodeComponent(title),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    tooltip: '搜索',
                    onPressed: () {
                      Navigator.pushNamed(context, "/search/");
                    },
                  ),
                ],
              )
            : null,
        body: Body(id: id));
  }
}
