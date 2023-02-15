import 'package:flutter/material.dart';
import 'package:flutter_features/utils/colors.dart';
import 'package:flutter_features/utils/extensions/widget_extensions.dart';
import 'package:flutter_features/utils/styles/text_style.dart';
import 'package:video_player/video_player.dart';

class NetworkVideoPlayerView extends StatefulWidget {
  const NetworkVideoPlayerView({Key? key}) : super(key: key);

  @override
  State<NetworkVideoPlayerView> createState() => _NetworkVideoPlayerViewState();
}

class _NetworkVideoPlayerViewState extends State<NetworkVideoPlayerView>
     {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
      body: Column(
        children: [
          Text(
            "Video Player",
            style: AppTextStyles.boldTextStyle(),
          ).paddingSymmetric(vertical: 10),
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    children: [
                      VideoPlayer(
                        _controller,
                      ),
                      Positioned(
                          bottom: 5,
                          left: 10,
                          right: 10,
                          child: VideoProgressIndicator(
                            _controller,
                            allowScrubbing: true,
                            colors: const VideoProgressColors(
                                bufferedColor: Colors.white,
                                playedColor: indicatorColor),
                          ))
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ).border(width: 0, borderRadius: 2.0).paddingAll(10)
        ],
      ),
    );
  }
}
