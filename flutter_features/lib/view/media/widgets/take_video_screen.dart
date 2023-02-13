import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_features/utils/extensions/widget_extensions.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/helpers/media/media_helper.dart';
import '../../../utils/sizes/app_sizes.dart';
import '../../../utils/sizes/border_radius.dart';
import '../../../utils/styles/text_style.dart';
import 'package:video_player/video_player.dart';

class TakeVideoScreen extends StatefulWidget {
  final String mediaType;
  const TakeVideoScreen({Key? key, required this.mediaType}) : super(key: key);

  @override
  State<TakeVideoScreen> createState() => _TakeVideoScreenState();
}

class _TakeVideoScreenState extends State<TakeVideoScreen> {
  final _transformationController = TransformationController();
  TapDownDetails? _doubleTapDetails;

   VideoPlayerController? _controller;

  @override
  Widget build(BuildContext context) {
    var height = screenHeight(context);
    var media = MediaHelper();

    return Scaffold(
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          10.height,
          Text(
            "Video",
            style: AppTextStyles.boldTextStyle(),
          ).center(),
          Container(
            height: height / 2,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: circularBorderRadius(),
                border: Border.all(width: 1, color: Colors.black)),
            child: GestureDetector(
              onDoubleTapDown: _handleDoubleTapDown,
              onDoubleTap: _handleDoubleTap,
              onTap: (){
                if(_controller !=null){
                  _controller!.play();
                }
              },
              child: InteractiveViewer(
                transformationController: _transformationController,
                panEnabled: true,
                minScale: 0.5,
                maxScale: 2,
                child: Center(
                    child: _controller != null
                        ? AspectRatio(aspectRatio: _controller!.value.aspectRatio,
                        child: VideoPlayer(_controller!))
                        : Text(widget.mediaType == "camera"?"Click on open camera":"Click on open files")),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: ()async {
                if(widget.mediaType == 'camera'){
                  var i =  await media.takeVideoFromCamera();
                  _updateImagePath(i);
                }else{
                  var i =  await media.getVideosFromGallery();
                  _updateImagePath(i);
                }

              },
              child: Text(widget.mediaType == "camera"?"Open Camera":"Open Files"))
              .paddingSymmetric(horizontal: 10)
        ],
      ),
    );
  }

  _updateImagePath(XFile? i){
    if(i != null){
      _controller = VideoPlayerController.file(
          File(i.path),videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true))
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
    }
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails!.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
      // Fox a 2x zoom
      // ..translate(-position.dx, -position.dy)
      // ..scale(2.0);
    }
  }
}
