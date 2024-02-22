import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneSearch extends StatefulWidget {
  final Function onChanged;

  const PhoneSearch({super.key, required this.onChanged});

  @override
  State<StatefulWidget> createState() => _PhoneSearchState();
}

class _PhoneSearchState extends State<PhoneSearch> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: (MediaQuery.of(context).size.width - 80.w),
          height: 30.h,
          padding: EdgeInsets.zero,
          child: TextField(
            autofocus: true,
            controller: _textController,
            cursorColor: Colors.white,
            textAlignVertical: TextAlignVertical.bottom,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xF1F3F4F5),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              prefixIconConstraints: const BoxConstraints(minWidth: 40).r,
              border: InputBorder.none,
              hintText: '搜索影片的名字',
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
              hoverColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5.0).w,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5.0).w,
              ),
            ),
            onSubmitted: (value) {
              if (value.isEmpty) {
                return;
              }
              _textController.text = value;
              widget.onChanged(value);
            },
            onEditingComplete: () {
              developer.log('搜索完成');
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            '取消',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
