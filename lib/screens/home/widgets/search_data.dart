import 'package:flutter/material.dart';

class SearchDataWidget extends InheritedWidget {
  final String data;

  const SearchDataWidget({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  //定义一个便捷的方法，方便子树中的 widget获取共享数据
  static SearchDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SearchDataWidget>();
  }

  ///该回调决定当 data 发生变化的时候，是否通知子树中依赖 data 的 widget
  @override
  bool updateShouldNotify(SearchDataWidget old) {
    return old.data != data;
  }
}
