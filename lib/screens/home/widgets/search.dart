import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 500,
            height: 50,
            padding: const EdgeInsets.all(0),
            child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xF1F3F4F5),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  prefixIconConstraints: const BoxConstraints(minWidth: 50),
                  border: InputBorder.none,
                  hintText: '搜索影片的名字',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  hoverColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                onSubmitted: (value) {
                  if (value == "") {
                    return;
                  }
                  developer.log(value, name: '搜索');
                  Navigator.pushNamed(context, '/detail');
                },
                onEditingComplete: () {
                  developer.log('搜索完成');
                }),
          ),
        ],
      ),
    );
  }
}
