import 'package:flutter/material.dart';

class TextFieldBorders {
  static OutlineInputBorder textFieldBorder(
      {double? borderWidth, Color? borderColor, double? borderRadius}) {
    return _inputBorder(
        borderColor: borderColor,
        borderRadius: borderRadius,
        borderWidth: borderWidth);
  }

  static OutlineInputBorder textFieldEnableBorder(
      {double? borderWidth, Color? borderColor, double? borderRadius}) {
    return _inputBorder(
        borderColor: borderColor,
        borderRadius: borderRadius,
        borderWidth: borderWidth);
  }

  static OutlineInputBorder textFieldFocusBorder(
      {double? borderWidth, Color? borderColor, double? borderRadius}) {
    return _inputBorder(
        borderColor: borderColor,
        borderRadius: borderRadius,
        borderWidth: borderWidth);
  }

  static OutlineInputBorder textFieldErrorBorder(
      {double? borderWidth, Color? borderColor, double? borderRadius}) {
    return _inputBorder(
        borderColor: borderColor,
        borderRadius: borderRadius,
        borderWidth: borderWidth);
  }

  OutlineInputBorder textFieldDisableBorder(
      {double? borderWidth, Color? borderColor, double? borderRadius}) {
    return _inputBorder(
        borderColor: borderColor,
        borderRadius: borderRadius,
        borderWidth: borderWidth);
  }

  static OutlineInputBorder _inputBorder(
          {double? borderWidth, Color? borderColor, double? borderRadius}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 4)),
        borderSide: BorderSide(
            width: borderWidth ?? 2.0,
            color: borderColor ?? Colors.transparent),
      );
}
