import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final String wd;
  const Result({super.key, required this.wd});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  late String result;

  // 更新上级组件传参的变化
  @override
  void didUpdateWidget(covariant Result oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      result = widget.wd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 130,
      child: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.only(left: 20, right: 20),
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 1.8,
        children: [1, 2, 3, 4, 5].map((e) => _buildItem('$e')).toList(),
      ),
    );
  }

  Widget _buildItem(String name) {
    return Container(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(10),
      color: const Color(0xFFFFFFFF),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: 'https://picsum.photos/200?image=10',
            width: 120,
            height: 200,
            fit: BoxFit.fitHeight,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 20),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 10, top: 5, right: 10, bottom: 5),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1E1E1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        '2023',
                        style:
                            TextStyle(color: Color(0xFF6D6D6D), fontSize: 12),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 10, top: 5, right: 10, bottom: 5),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1E1E1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        '中国',
                        style:
                            TextStyle(color: Color(0xFF6D6D6D), fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                const Text.rich(
                  TextSpan(
                      text: "导演: ",
                      style: TextStyle(color: Color(0xFF797A7A)),
                      children: [
                        TextSpan(
                            text: "未知",
                            style: TextStyle(color: Color(0xFF3C3C3C))),
                      ]),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                const Text.rich(
                  TextSpan(
                      text: "主演: ",
                      style: TextStyle(color: Color(0xFF797A7A)),
                      children: [
                        TextSpan(
                            text: "未知",
                            style: TextStyle(color: Color(0xFF3C3C3C))),
                        TextSpan(
                            text: " / ",
                            style: TextStyle(color: Color(0xFFD7DAE1))),
                        TextSpan(
                            text: "未知",
                            style: TextStyle(color: Color(0xFF3C3C3C))),
                        TextSpan(
                            text: " / ",
                            style: TextStyle(color: Color(0xFFD7DAE1))),
                        TextSpan(
                            text: "未知",
                            style: TextStyle(color: Color(0xFF3C3C3C))),
                      ]),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  margin: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFE952E),
                        Color(0xFFFE6229),
                        Color(0xFFFF4D43),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/detail/1');
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: const Text(
                      '在线观看',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
