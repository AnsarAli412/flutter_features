import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_features/utils/colors.dart';
import 'package:flutter_features/utils/extensions/widget_extensions.dart';
import 'package:flutter_features/utils/helpers/media/media_helper.dart';
import 'package:flutter_features/utils/sizes/app_sizes.dart';
import 'package:flutter_features/view/media/widgets/multiple_image_view.dart';
import 'package:flutter_features/view/media/widgets/network_video_player_view.dart';
import 'package:flutter_features/view/media/widgets/single_image_view.dart';
import 'package:flutter_features/view/media/widgets/take_video_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../bottom_sheet/bottom_sheet_view.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({Key? key}) : super(key: key);

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  var media = MediaHelper();
  List<XFile>? images = [];
  XFile? cameraImage;
  XFile? myVideo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Media"),
      ),
      body: mediaView(),
    );
  }

  mediaView() {
    var height = screenHeight(context);
    return ListView(
      children: [
        _itemView(
            title: "Open Camera",
            subtitle: "Open camera and take image",
            icon: Icons.camera_alt,
            onTap: () {
              ShowAppBottomSheetView(context: context).showSheetFromBottomView(
                  child: SizedBox(
                    height: height / 1.5,
                    child: const SingleImageView(mediaType: 'camera'),
                  ),
                  isExpended: true);
            }).paddingSymmetric(vertical: 5),
        _itemView(
            title: "Open Gallery",
            subtitle: "Open gallery and take image",
            icon: Icons.photo_camera_back,
            onTap: () {
              ShowAppBottomSheetView(context: context).showSheetFromBottomView(
                  child: SizedBox(
                    height: height / 1.5,
                    child: const SingleImageView(mediaType: 'gallery'),
                  ),
                  isExpended: true);
            }).paddingSymmetric(vertical: 5),
        _itemView(
            title: "Multiple Image",
            subtitle: "Open gallery and take multiple image",
            icon: Icons.photo_library_outlined,
            onTap: () {
              ShowAppBottomSheetView(context: context).showSheetFromBottomView(
                  child: SizedBox(
                    height: height / 1.2,
                    child: const MultipleImageView(),
                  ),
                  isExpended: true);
            }).paddingSymmetric(vertical: 5),
        _itemView(
            title: "Video by camera",
            subtitle: "Record a video by your camera",
            icon: Icons.videocam_rounded,
            onTap: () {
              ShowAppBottomSheetView(context: context).showSheetFromBottomView(
                  child: SizedBox(
                    height: height / 1.5,
                    child:  const TakeVideoScreen(mediaType: 'camera'),
                  ),
                  isExpended: true);
            }).paddingSymmetric(vertical: 5),
        _itemView(
            title: "Video by gallery",
            subtitle: "Record a video by your files",
            icon: Icons.videocam_rounded,
            onTap: () {
              ShowAppBottomSheetView(context: context).showSheetFromBottomView(
                  child: SizedBox(
                    height: height / 1.5,
                    child:  const TakeVideoScreen(mediaType: 'gallery'),
                  ),
                  isExpended: true);
            }).paddingSymmetric(vertical: 5),
        _itemView(
            title: "Play network video",
            subtitle: "Download or add url of video and play it",
            icon: Icons.videocam_rounded,
            onTap: () {
              ShowAppBottomSheetView(context: context).showSheetFromBottomView(
                  child: SizedBox(
                    height: height / 2,
                    child:  const NetworkVideoPlayerView(),
                  ),
                  isExpended: true);
            }).paddingSymmetric(vertical: 5),
      ],
    );
  }

  Widget _itemView(
      {required String title,
      required String subtitle,
      IconData icon = Icons.history_toggle_off,
      void Function()? onTap}) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(icon),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.keyboard_arrow_right),
      onTap: onTap,
    );
  }

  _mainView() {
    var height = screenHeight(context);
    var width = screenWidth(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          height: height / 1.3,
          width: width,
          decoration:
              BoxDecoration(border: Border.all(width: 2, color: Colors.black)),
          child: Column(
            children: [
              Center(
                child: cameraImage == null
                    ? const Text("no data")
                    : Image.file(
                        File(cameraImage!.path),
                        height: height / 4,
                      ),
              ),
              Expanded(child: _multiImageView())
            ],
          ),
        ),
        Row(
          children: [
            ElevatedButton(
                onPressed: () async {
                  var image = await media.takeImageFromCamera();
                  setState(() {
                    cameraImage = image;
                  });
                },
                child: const Text("Camera")),
            ElevatedButton(
                onPressed: () async {
                  List<XFile> image = await media.getMultiImageFromGallery();
                  if (image.isNotEmpty) {
                    images = image;
                    setState(() {});
                  }
                },
                child: const Text("m-i")),
            ElevatedButton(
                onPressed: () async {
                  XFile? image = await media.getImageFromGallery();
                  if (image != null) {
                    cameraImage = image;
                    setState(() {});
                  }
                },
                child: const Text("Gallery")),
            ElevatedButton(
                onPressed: () async {
                  var video = await media.takeVideoFromCamera();
                  if (video != null) {
                    setState(() {
                      cameraImage = video;
                    });
                  }
                },
                child: const Text("Video")),
            ElevatedButton(
                onPressed: () async {
                  var video = await media.getVideosFromGallery();
                  if (video != null) {
                    setState(() {
                      cameraImage = video;
                    });
                  }
                },
                child: const Text("s-v"))
          ],
        )
      ],
    );
  }

  createDocPDF() {
    final pdf = pw.Document();
    final image = pw.MemoryImage(
      File(cameraImage!.path).readAsBytesSync(),
    );

    var a = pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(
        child: pw.Image(image),
      ); // Center
    }));
  }

  _multiImageView() {
    return GridView.builder(
        itemCount: images!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            childAspectRatio: .5,
            mainAxisSpacing: 5),
        itemBuilder: (co, index) {
          return images!.isEmpty
              ? const Text("Select multi image")
              : Image.file(
                  File(images![index].path),
                  fit: BoxFit.contain,
                );
        });
  }
}
