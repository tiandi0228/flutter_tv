import 'package:flutter/material.dart';
import 'package:flutter_tv/screens/detail/widgets/body.dart';

class DetailScreen extends StatelessWidget {
  final String id;
  const DetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body(id: id));
  }
}
