import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tv/screens/search/widgets/page.dart';
import 'package:flutter_tv/screens/search/widgets/phone_result.dart';
import 'package:flutter_tv/screens/search/widgets/result.dart';
import 'package:flutter_tv/screens/search/widgets/search.dart';
import 'package:flutter_tv/utils/platform_util.dart';

class Body extends StatefulWidget {
  final String wd;

  const Body({super.key, required this.wd});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String _result;
  int _pageNum = 1;
  late bool _isRefresh = false;

  @override
  void initState() {
    super.initState();

    if (widget.wd.isEmpty) return;

    setState(() {
      _result = Uri.decodeComponent(widget.wd);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (PlatformUtils.isMacOS || PlatformUtils.isWindows)
          Container(
            margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(5),
              top: ScreenUtil().setWidth(15),
              right: ScreenUtil().setWidth(5),
              bottom: ScreenUtil().setWidth(5),
            ),
            child: Column(
              children: [
                Search(
                  wd: _result,
                  onChanged: (String val) {
                    if (val.isEmpty) {
                      return;
                    }
                    setState(() {
                      _result = val;
                      _isRefresh = true;
                    });
                    developer.log(_result, name: '搜索返回结果');
                  },
                ),
                Result(wd: _result, page: _pageNum),
                Pager(
                  wd: _result,
                  page: _isRefresh ? 1 : _pageNum,
                  onChanged: (int page) {
                    setState(() {
                      _pageNum = page;
                    });
                    developer.log('$page', name: '分页');
                  },
                ),
              ],
            ),
          ),
        if (PlatformUtils.isAndroid || PlatformUtils.isIOS) const PhoneResult(),
      ],
    );
  }
}
