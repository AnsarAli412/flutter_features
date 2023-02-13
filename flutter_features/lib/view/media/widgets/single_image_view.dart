import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_features/utils/extensions/widget_extensions.dart';
import 'package:flutter_features/utils/helpers/media/media_helper.dart';
import 'package:flutter_features/utils/sizes/border_radius.dart';
import 'package:flutter_features/utils/styles/text_style.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/sizes/app_sizes.dart';

class SingleImageView extends StatefulWidget {
  final String mediaType;
  const SingleImageView({Key? key, required this.mediaType}) : super(key: key);

  @override
  State<SingleImageView> createState() => _SingleImageViewState();
}

class _SingleImageViewState extends State<SingleImageView> {
  XFile? image;
  final _transformationController = TransformationController();
  TapDownDetails? _doubleTapDetails;

  @override
  Widget build(BuildContext context) {
    var height = screenHeight(context);
    var width = screenWidth(context);
    var media = MediaHelper();

    return Scaffold(
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          10.height,
          Text(
            "Image",
            style: AppTextStyles.boldTextStyle(),
          ).center(),
          Container(
            height: height / 2,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: circularBorderRadius(),
                border: Border.all(width: 1, color: Colors.black)),
            child: GestureDetector(
              onDoubleTapDown: _handleDoubleTapDown,
              onDoubleTap: _handleDoubleTap,
              child: InteractiveViewer(
                transformationController: _transformationController,
                panEnabled: true,
                minScale: 0.5,
                maxScale: 2,
                child: Center(
                    child: image != null
                        ? Image.file(File(image!.path),height: height/2,width: width,fit: BoxFit.contain,)
                        : Text(widget.mediaType == "camera"?"Click on open camera":"Click on open gallery")),
              ),
            ),
          ),
          ElevatedButton(
                  onPressed: ()async {
                   if(widget.mediaType == 'camera'){
                     var i =  await media.takeImageFromCamera();
                     _updateImagePath(i);
                   }else{
                     var i =  await media.getImageFromGallery();
                     _updateImagePath(i);
                   }

                  },
                  child: Text(widget.mediaType == "camera"?"Open Camera":"Open Gallery"))
              .paddingSymmetric(horizontal: 10)
        ],
      ),
    );
  }

  _updateImagePath(XFile? i){
    if(i != null){
      setState(() {
        image = i;
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
