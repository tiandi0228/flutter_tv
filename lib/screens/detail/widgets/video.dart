import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tv/service/video.dart';
import 'package:flutter_tv/utils/format_duration_util.dart';
import 'package:video_player/video_player.dart';
import 'dart:developer' as developer;

class VideoPlay extends StatefulWidget {
  final String id;
  const VideoPlay({super.key, required this.id});

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  late VideoPlayerController _controller;
  bool _videoInit = false;
  int _firstRun = 0;
  String url = "";
  String _totalDuration = "0:00:00";
  String _position = "0:00:00";

  @override
  void initState() {
    super.initState();
    fetchVideo(widget.id).then(
      (data) => {
        setState(() {
          url = data;
        }),
        _urlChange(data),
      },
    );
  }

  void _urlChange(String url) async {
    if (url.isEmpty) return;
    _controller = VideoPlayerController.network(url);
    _controller.addListener(_videoListener);
    await _controller.initialize();
    developer.log("${_controller.value.position}", name: "加载完成");
    setState(() {
      _videoInit = true;
      _firstRun = 0;
      _totalDuration =
          FormatDurationUtil.formatDuration(_controller.value.duration);
    });
  }

  @override
  void didChangeDependencies() {
    try {
      _urlChange('');
    } catch (e) {
      developer.log('$e', name: '加载播放器失败');
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _videoListener() async {
    Duration res = _controller.value.position;
    if (res >= _controller.value.duration) {
      await _controller.seekTo(const Duration(seconds: 0));
      await _controller.pause();
    }
    if (_controller.value.isPlaying) {
      setState(() {
        _position =
            FormatDurationUtil.formatDuration(_controller.value.position);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _isUrl(),
        if (_videoInit) _buildTools(),
      ],
    );
  }

  Widget _isUrl() {
    if (url.isEmpty) {
      return AspectRatio(
        aspectRatio: 3 / 1.5,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          color: Colors.black,
          child: const Text(
            '暂无视频信息',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      );
    } else {
      return _isVideoInit();
    }
  }

  Widget _isVideoInit() {
    if (_videoInit) {
      if (_firstRun == 0) {
        return _buildPlayerInit();
      }
      return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      );
    } else {
      return _buildLoading();
    }
  }

  Widget _buildLoading() {
    return AspectRatio(
      aspectRatio: 3 / 1.5,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        color: Colors.black,
        child: const Text(
          '正在加载中……',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerInit() {
    return AspectRatio(
      aspectRatio: 3 / 1.5,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://static.yximgs.com/bs2/adcarsku/skuc89bfa00-5ed0-42d0-9209-db3b6f500922.jpg',
            width: MediaQuery.of(context).size.width,
            height: 400,
            fit: BoxFit.cover,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          _buildPlayerButton(),
        ],
      ),
    );
  }

  Widget _buildPlayerButton() {
    return Positioned(
      left: (MediaQuery.of(context).size.width - 60) / 2,
      top: 150,
      child: Container(
        padding: EdgeInsets.zero,
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60.0),
          color: Colors.white60,
        ),
        child: IconButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
              _firstRun = _firstRun + 1;
            });
          },
          icon: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  Widget _buildTools() {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 40,
      color: Colors.black,
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
                _firstRun = _firstRun + 1;
              });
            },
            iconSize: 26,
            icon: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.grey,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              '$_position / $_totalDuration',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
