import 'package:flutter/material.dart';
import 'package:flutter_tv/screens/home/widgets/search_data.dart';
import 'package:flutter_tv/screens/search/widgets/body.dart';
import 'package:flutter_tv/screens/search/widgets/phone_search.dart';
import 'package:flutter_tv/utils/platform_util.dart';

class SearchScreen extends StatefulWidget {
  final String wd;

  const SearchScreen({super.key, required this.wd});

  @override
  State<StatefulWidget> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  String _keyword = "";

  @override
  void initState() {
    super.initState();

    setState(() {
      _keyword = widget.wd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SearchDataWidget(
      data: _keyword,
      child: Scaffold(
        appBar: (!PlatformUtils.isMacOS && !PlatformUtils.isWindows)
            ? AppBar(
                backgroundColor: Colors.black,
                actions: [
                  PhoneSearch(
                    onChanged: (val) {
                      setState(() {
                        _keyword = val;
                      });
                    },
                  ),
                ],
              )
            : null,
        body: Body(wd: _keyword),
      ),
    );
  }
}
