import 'package:flutter/material.dart';
import 'package:flutter_tv/service/pager.dart';
import 'package:pagination_flutter/pagination.dart';

class Pager extends StatefulWidget {
  final String wd;
  final int page;
  final Function onChanged;
  const Pager(
      {super.key,
      required this.wd,
      required this.page,
      required this.onChanged});

  @override
  State<Pager> createState() => _PagerState();
}

class _PagerState extends State<Pager> {
  int total = 1;
  int selectedPage = 1;

  @override
  void initState() {
    super.initState();
    if (selectedPage >= 2) return;
    fetchSearchPager(widget.wd, widget.page).then((data) {
      setState(() {
        total = data;
        selectedPage = widget.page;
      });
    });
  }

  @override
  void didUpdateWidget(covariant Pager oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (selectedPage >= 2) return;
    fetchSearchPager(widget.wd, widget.page).then((data) {
      setState(() {
        total = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Pagination(
        numOfPages: total,
        selectedPage: selectedPage,
        pagesVisible: 5,
        spacing: 0,
        onPageChanged: (page) {
          widget.onChanged(page);
          setState(() {
            selectedPage = page;
          });
        },
        nextIcon: const Icon(
          Icons.arrow_circle_right_outlined,
          color: Colors.amberAccent,
          size: 35,
        ),
        previousIcon: const Icon(
          Icons.arrow_circle_left_outlined,
          color: Colors.amberAccent,
          size: 35,
        ),
        activeTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        activeBtnStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.amber),
          elevation: MaterialStateProperty.all(15),
        ),
        inactiveBtnStyle: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
        ),
        inactiveTextStyle: const TextStyle(
          fontSize: 14,
          color: Colors.amber,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
