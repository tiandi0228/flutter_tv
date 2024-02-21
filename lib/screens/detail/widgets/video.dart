import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tv/service/video.dart';
import 'package:flutter_tv/utils/format_duration_util.dart';
import 'package:flutter_tv/utils/window_util.dart';
import 'package:video_player/video_player.dart';
import 'dart:developer' as developer;

class VideoPlay extends StatefulWidget {
  final String id;
  final Function onChangeFullScreen;
  const VideoPlay(
      {super.key, required this.id, required this.onChangeFullScreen});

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  late VideoPlayerController _controller;
  bool _videoInit = false;
  int _firstRun = 0;
  String url = "";
  String _totalDuration = "00:00:00";
  String _position = "00:00:00";
  double _progressValue = 0.0;
  String _labelProgress = "00:00:00";
  double _volumeValue = 0.0;
  bool _isFullScreen = false;

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
    developer.log("加载完成");
    setState(() {
      _videoInit = true;
      _firstRun = 0;
      _totalDuration =
          FormatDurationUtil.formatDuration(_controller.value.duration);
      _volumeValue = _controller.value.volume;
    });
  }

  @override
  void didChangeDependencies() {
    try {
      _urlChange('');
    } catch (e) {
      developer.log('$e', name: '加载播放器失败');
    }
    WindowUtil.isFullScreen().then((value) => {
          if (!value) WindowUtil.setResizable(false),
          setState(() {
            _isFullScreen = value;
          })
        });
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    developer.log('暂时销毁');
    super.deactivate();
  }

  @override
  void dispose() {
    developer.log('销毁');
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
      int position = _controller.value.position.inMilliseconds;
      int duration = _controller.value.duration.inMilliseconds;
      if (position >= duration) {
        position = duration;
      }
      setState(() {
        _position =
            FormatDurationUtil.formatDuration(_controller.value.position);
        _progressValue = position / duration * 100;
        _labelProgress = _position;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _isUrl(),
        if (_videoInit) _buildProgress(),
        if (_videoInit) _buildTools(),
      ],
    );
  }

  Widget _isUrl() {
    if (url.isEmpty) {
      return AspectRatio(
        aspectRatio: _isFullScreen ? 2 / 1 : 3 / 1.5,
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
        aspectRatio: _isFullScreen ? 2 / 1 : _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      );
    } else {
      return _buildLoading();
    }
  }

  Widget _buildLoading() {
    return AspectRatio(
      aspectRatio: _isFullScreen ? 2 / 1 : 3 / 1.5,
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
      aspectRatio: _isFullScreen ? 2 / 1 : 3 / 1.5,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://static.yximgs.com/bs2/adcarsku/skuc89bfa00-5ed0-42d0-9209-db3b6f500922.jpg',
            width: MediaQuery.of(context).size.width,
            height: _isFullScreen ? MediaQuery.of(context).size.height : 400,
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
      top: _isFullScreen ? (MediaQuery.of(context).size.height - 300) / 2 : 150,
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

  Widget _buildProgress() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.blue,
        inactiveTrackColor: Colors.white,
        valueIndicatorColor: Colors.blue,
        inactiveTickMarkColor: Colors.white,
        overlayShape: const RoundSliderOverlayShape(
          overlayRadius: 10,
        ),
        thumbColor: Colors.blue,
        thumbShape: const RoundSliderThumbShape(
          disabledThumbRadius: 7,
          enabledThumbRadius: 7,
        ),
      ),
      child: Slider(
        value: _progressValue,
        label: _labelProgress,
        divisions: 100,
        onChangeStart: (val) {
          developer.log('$val');
          _controller.pause();
        },
        onChangeEnd: (val) {
          developer.log('$val');
          int duration = _controller.value.duration.inMilliseconds;
          _controller.seekTo(
            Duration(milliseconds: (_progressValue / 100 * duration).toInt()),
          );
          Future.delayed(const Duration(seconds: 1))
              .whenComplete(() => _controller.play());
        },
        onChanged: (value) {
          setState(() {
            _progressValue = value;
            _labelProgress =
                FormatDurationUtil.formatDuration(_controller.value.position);
          });
        },
        min: 0,
        max: 100,
      ),
    );
  }

  Widget _buildTools() {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 40,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
              _buildVolume(),
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
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              WindowUtil.setResizable(true);
              WindowUtil.setFullScreen(!_isFullScreen);
              widget.onChangeFullScreen(!_isFullScreen);
              setState(() {
                _isFullScreen = !_isFullScreen;
              });
            },
            icon: Icon(
                _isFullScreen
                    ? Icons.fit_screen_rounded
                    : Icons.fullscreen_rounded,
                color: Colors.grey),
          )
        ],
      ),
    );
  }

  IconData _buildVolumeIcon() {
    if (_volumeValue == 0) {
      return Icons.volume_mute_rounded;
    } else if (_volumeValue < 100) {
      return Icons.volume_down_rounded;
    }
    return Icons.volume_up_rounded;
  }

  Widget _buildVolume() {
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          Icon(
            _buildVolumeIcon(),
            color: Colors.grey,
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.blue,
              inactiveTrackColor: Colors.white,
              valueIndicatorColor: Colors.blue,
              inactiveTickMarkColor: Colors.white,
              overlayShape: const RoundSliderOverlayShape(
                overlayRadius: 5,
              ),
              thumbColor: Colors.blue,
              thumbShape: const RoundSliderThumbShape(
                disabledThumbRadius: 5,
                enabledThumbRadius: 5,
              ),
            ),
            child: Slider(
              value: _volumeValue,
              label: '${_volumeValue.toInt()}%',
              divisions: 100,
              min: 0,
              max: 100,
              onChanged: (value) {
                _controller.setVolume(
                    NumUtil.getNumByValueDouble(value, 1)!.toDouble());
                setState(() {
                  _volumeValue =
                      NumUtil.getNumByValueDouble(value, 1)!.toDouble();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
