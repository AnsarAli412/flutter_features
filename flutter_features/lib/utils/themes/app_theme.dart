import 'package:flutter/material.dart';
import 'package:flutter_features/utils/colors.dart';
import 'package:flutter_features/utils/shapes/app_shapes.dart';
import 'package:flutter_features/utils/sizes/default_sizes.dart';
import 'package:flutter_features/utils/styles/text_style.dart';

class AppThemeData {
  BuildContext context;

  AppThemeData({required this.context});

  double aapBarElevation = 5;

  ThemeData theme() {
    return ThemeData(
      scaffoldBackgroundColor: scaffoldBgColor,
      appBarTheme: _appBarThemeData(isCenter: true),
      iconTheme: _iconThemeData(),
      textTheme: _textThemeData(),
      elevatedButtonTheme: _buttonThemeData(),
      bottomAppBarTheme: _bottomAapBarTheme(),
      bottomNavigationBarTheme: _bottomNavigationBarThemeData(),
      bottomSheetTheme: _bottomSheetThemeData(),
      cardTheme: _cardThemeData(),
      listTileTheme: _listTileTheme(),
      progressIndicatorTheme: _progressIndicatorThemeData(),
      floatingActionButtonTheme:_floatingActionButtonThemeData(),
    );
  }

  _appBarThemeData({bool isCenter = false}) {
    return AppBarTheme(
      backgroundColor: appbarBgColor,
      elevation: aapBarElevation,
      actionsIconTheme: _iconThemeData(),
      centerTitle: isCenter,
      iconTheme: _iconThemeData(),
      titleTextStyle: AppTextStyles.appbarTextStyle(txtColor: appBarTextColor),
      toolbarTextStyle: AppTextStyles.normalTextStyle(),
    );
  }

  _iconThemeData(
          {double iconSize = appBarIconSize,
          Color iconColor = appBarActionsIconColor}) =>
      IconThemeData(size: iconSize, color: iconColor);

  _textThemeData() => Theme.of(context)
      .textTheme
      .apply(bodyColor: textColor, displayColor: textColor);

  _bottomAapBarTheme() {
    return BottomAppBarTheme(
      color: appbarBgColor,
      elevation: aapBarElevation,
    );
  }

  _buttonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: circularBorderShape(),
          disabledBackgroundColor: disableBtnColor,
          fixedSize: const Size.fromHeight(45)),
      // textTheme: ButtonTextTheme.normal
    );
  }

  BottomNavigationBarThemeData _bottomNavigationBarThemeData() {
    return BottomNavigationBarThemeData(
        elevation: aapBarElevation,
        backgroundColor: bottomNavigationBarColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        selectedLabelStyle:
            AppTextStyles.normalTextStyle(txtColor: Colors.white),
        unselectedLabelStyle:
            AppTextStyles.normalTextStyle(txtColor: Colors.black));
  }

  BottomSheetThemeData _bottomSheetThemeData() {
    return const BottomSheetThemeData(
        modalElevation: 5,
        backgroundColor: bottomSheetBgColor,
        modalBackgroundColor: bottomSheetBgColor,
        clipBehavior: Clip.antiAlias);
  }

  CardTheme _cardThemeData() => const CardTheme(
        elevation: 5,
        color: cardBgColor,
      );

  _listTileTheme() => const ListTileThemeData(
        tileColor: tileColor,
        style: ListTileStyle.list,
        selectedTileColor: selectedTileColor,
      );

  ProgressIndicatorThemeData _progressIndicatorThemeData() {
    return const ProgressIndicatorThemeData(color: indicatorColor);
  }

  FloatingActionButtonThemeData _floatingActionButtonThemeData(){
    return const FloatingActionButtonThemeData(backgroundColor: buttonColor);
  }
}
