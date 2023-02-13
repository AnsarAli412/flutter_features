import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_features/utils/extensions/widget_extensions.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/helpers/media/media_helper.dart';
import '../../../utils/sizes/app_sizes.dart';
import '../../../utils/sizes/border_radius.dart';
import '../../../utils/styles/text_style.dart';

class MultipleImageView extends StatefulWidget {
  const MultipleImageView({Key? key}) : super(key: key);

  @override
  State<MultipleImageView> createState() => _MultipleImageViewState();
}

class _MultipleImageViewState extends State<MultipleImageView> {
  List<XFile> images = [];
  final _transformationController = TransformationController();
  TapDownDetails? _doubleTapDetails;

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
            "Multiple Images",
            style: AppTextStyles.boldTextStyle(),
          ).center(),
          Container(
            height: height / 1.45,
            margin: const EdgeInsets.all(10),
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
                child: _multiImageView(),
              ),
            ),
          ),
          ElevatedButton(
                  onPressed: () async {
                    List<XFile> image = await media.getMultiImageFromGallery();
                    if (image.isNotEmpty) {
                      images = image;
                      setState(() {});
                    }
                  },
                  child: const Text("Open Gallery"))
              .paddingSymmetric(horizontal: 10)
        ],
      ),
    );
  }

  _multiImageView() {
    return images.isNotEmpty
        ? GridView.builder(
      padding: const EdgeInsets.all(5),
            itemCount: images.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                childAspectRatio: .5,
                mainAxisSpacing: 5),
            itemBuilder: (co, index) {
              return Image.file(
                File(images[index].path),
                fit: BoxFit.contain,
              );
            })
        : const Text("Select multi image").center();
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
