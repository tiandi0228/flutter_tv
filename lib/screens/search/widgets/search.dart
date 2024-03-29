import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Search extends StatefulWidget {
  final String wd;
  final Function onChanged;

  const Search({
    super.key,
    required this.wd,
    required this.onChanged,
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _textController.text = widget.wd;
  }

  @override
  void didUpdateWidget(covariant Search oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    _textController.text = widget.wd;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildDesktop();
  }

  Widget _buildDesktop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250.w,
          height: 50.h,
          margin: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
          child: TextField(
            controller: _textController,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xF1F3F4F5),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              prefixIconConstraints: const BoxConstraints(minWidth: 50).r,
              border: InputBorder.none,
              hintText: '搜索影片的名字',
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
              hoverColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50.0).w,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50.0).w,
              ),
            ),
            onSubmitted: (value) {
              if (value == "") {
                return;
              }
              widget.onChanged(value);
            },
            onEditingComplete: () {
              developer.log('搜索完成');
            },
          ),
        ),
      ],
    );
  }
}
