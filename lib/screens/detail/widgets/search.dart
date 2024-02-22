import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 250.w,
            height: 40.h,
            padding: const EdgeInsets.all(0),
            child: TextField(
              // textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xF1F3F4F5),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                prefixIconConstraints: const BoxConstraints(minWidth: 50).r,
                contentPadding: const EdgeInsets.all(2),
                border: InputBorder.none,
                hintText: '搜索影片的名字',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                hoverColor: const Color(0xF1F3F4F5),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(40.0).w,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(40.0).w,
                ),
              ),
              onSubmitted: (value) {
                if (value.isEmpty) {
                  return;
                }
                String params = Uri.encodeComponent(value);
                developer.log(params, name: '搜索');
                Navigator.pushNamed(context, '/search/$params');
              },
              onEditingComplete: () {
                developer.log('搜索完成');
              },
            ),
          ),
        ],
      ),
    );
  }
}
