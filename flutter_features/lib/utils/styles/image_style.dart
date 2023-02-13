import 'package:flutter/material.dart';


import '../colors.dart';


/// import cached_network_image for image

// Widget showNetworkImageWithCached({
//   required String imageUrl,
//   required double height,
//   required double width,
//   required double radius,
//   BoxFit fit = BoxFit.cover,
//   Widget? errorView
// }) {
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(radius),
//     child: CachedNetworkImage(
//       height: height,
//       width: width,
//       imageUrl: imageUrl,
//       fit: fit,
//       errorWidget: (c, a, b) {
//         return imageErrorView(height, width, radius,errorView??Container());
//       },
//       placeholder: (c, s) {
//         return imagePlaceHolderView(height, width, radius);
//       },
//     ),
//   );
// }

Widget imageErrorView(double height, double width, double radius,Widget view) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        color: imageBackgroundColor.withOpacity(.4),
        borderRadius: BorderRadius.circular(radius)),
    child: Center(
      child: view,
    ),
  );
}

Widget imagePlaceHolderView(double height, double width, double radius) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.3),
        borderRadius: BorderRadius.circular(radius)),
    child: const Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: progressIndicatorColor,
      ),
    ),
  );
}


/// import SVGImage package
//
// Widget showSVGImage(
//     {required String imagePath,
//     required double height,
//     required double width,
//     required double radius,
//       Color imageColor = Colors.black,
//     BoxFit fit = BoxFit.cover}) {
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(radius),
//     child: SvgPicture.network(
//       imagePath,
//       key: Key(imagePath),
//       height: height,
//       width: width,
//       color: imageColor,
//       fit: fit,
//       placeholderBuilder: (c) => imagePlaceHolderView(height, width, radius),
//     ),
//   );
// }
