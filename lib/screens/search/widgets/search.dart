import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class Search extends StatefulWidget {
  final String wd;
  final Function onChanged;
  const Search({super.key, required this.wd, required this.onChanged});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 500,
          height: 50,
          margin: const EdgeInsets.only(top: 20),
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
