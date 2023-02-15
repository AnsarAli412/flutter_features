import 'package:flutter/material.dart';
import 'package:flutter_features/utils/builders/read_more_text_builder.dart';
import 'package:flutter_features/utils/colors.dart';
import 'package:flutter_features/utils/sizes/default_sizes.dart';

class AppTextStyles {

  /// normal text style
   static TextStyle normalTextStyle({
    Color? txtColor,
    Color? bgColor,
    double size = normalTextSize,
    FontWeight? fontWeight,
    TextOverflow? overflow,
  }) {
    return TextStyle(
        backgroundColor: bgColor,
        color: txtColor??normalTextColor,
        fontSize: size,
        overflow: overflow,
        fontWeight: FontWeight.normal,);
  }

   /// bold text style
   static TextStyle boldTextStyle({
     Color? txtColor,
     Color? bgColor,
     double size = boldTextSize,
     FontWeight? fontWeight,
     TextOverflow? overflow,
   }) {
     return TextStyle(
       backgroundColor: bgColor,
       color: txtColor??normalTextColor,
       fontSize: size,
       overflow: overflow,
       fontWeight: FontWeight.bold,);
   }

   /// read more text style
   Widget showMoreTextView(
       String data, {
         Color moreTextColor = Colors.white,
         Color textColor = Colors.black,
         TextStyle? textStyle,
         TextStyle? moreTextStyle,
         TextStyle? lessTextStyle
       }) {
     return ReadMoreTextBuilder(
       data,
       textDirection: TextDirection.ltr,
       trimLines: 3,
       textAlign: TextAlign.left,
       trimMode: TrimMode.Line,
       trimCollapsedText: " Show More ",
       trimExpandedText: " Show Less ",
       lessStyle: lessTextStyle??boldTextStyle(),
       moreStyle: boldTextStyle(),
       style: textStyle??normalTextStyle(),
     );
   }

   static TextStyle appbarTextStyle({Color txtColor = normalTextColor,
     TextOverflow? overflow,})=> TextStyle(color: txtColor,fontWeight: FontWeight.bold,fontSize: appBarTextSize);

   static TextStyle buttonTextStyle({Color txtColor = normalTextColor,
     double textSize = 16,})=> TextStyle(color: txtColor,fontWeight: FontWeight.bold,fontSize: textSize);
}
