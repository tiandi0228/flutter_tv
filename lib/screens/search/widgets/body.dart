import 'package:flutter/material.dart';
import 'package:flutter_tv/screens/search/widgets/result.dart';
import 'package:flutter_tv/screens/search/widgets/search.dart';
import 'package:flutter_tv/screens/search/widgets/page.dart';
import 'dart:developer' as developer;

class Body extends StatefulWidget {
  final String wd;

  const Body({super.key, required this.wd});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String result;
  int pageNum = 1;
  late bool isRefresh = false;

  @override
  void initState() {
    super.initState();
    result = Uri.decodeComponent(widget.wd);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 10),
      child: Column(
        children: [
          Search(
            wd: result,
            onChanged: (String val) {
              if (val.isEmpty) {
                return;
              }
              setState(() {
                result = val;
                isRefresh = true;
              });
              developer.log(result, name: '搜索返回结果');
            },
          ),
          Result(wd: result, page: pageNum),
          Pager(
            wd: result,
            page: isRefresh ? 1 : pageNum,
            onChanged: (int page) {
              setState(() {
                pageNum = page;
              });
              developer.log('$page', name: '分页');
            },
          ),
        ],
      ),
    );
  }
}
