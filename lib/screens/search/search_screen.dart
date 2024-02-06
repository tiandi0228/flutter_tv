import 'package:flutter/material.dart';
import 'package:flutter_tv/screens/search/widgets/body.dart';

class SearchScreen extends StatelessWidget {
  final String wd;
  const SearchScreen({super.key, required this.wd});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(wd: wd),
    );
  }
}
