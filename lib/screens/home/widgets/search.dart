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
    return _buildDesktop();
  }

  Widget _buildDesktop() {
    return Container(
      height: 60.h,
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 250.w,
            height: 50.h,
            padding: const EdgeInsets.all(0),
            child: TextField(
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
                if (value.isEmpty) {
                  return;
                }
                String params = Uri.encodeComponent(value);
                developer.log(params, name: '搜索');
                Navigator.pushNamedAndRemoveUntil(
                    context, "/search/$params", (route) => false);
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
