import 'package:flutter/material.dart';
import 'package:flutter_tv/service/video.dart';
import 'package:qyplayer/qyplayer.dart';

class VideoPlay extends StatefulWidget {
  final String id;
  const VideoPlay({super.key, required this.id});

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  GlobalKey<QYPlayerState> playerKey = GlobalKey<QYPlayerState>();
  QYPlayerController? controller;
  String url = "";

  @override
  void initState() {
    super.initState();
    fetchVideo(widget.id).then(
      (data) => {
        setState(() {
          url = data;
        }),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 450,
      color: Colors.grey,
      child: Column(
        children: [
          if (url.isNotEmpty)
            QYPlayer(
              key: playerKey,
              controller: QYPlayerController(
                src:
                    url, //"https://vip.ffzyread.com/20231221/21285_2c84cb67/index.m3u8",
                width: MediaQuery.of(context).size.width,
                height: 450,
                poster: '',
                isLive: false,
                initTime: const Duration(seconds: 12),
                autoplay: false,
                useSafeArea: true,
                bgColor: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
