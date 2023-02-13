import 'package:flutter/material.dart';
import 'package:flutter_features/utils/helpers/internet/internet_helper.dart';
import 'package:flutter_features/utils/themes/app_theme.dart';
import 'package:flutter_features/view/demo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: AppThemeData(context: context).theme(),
      home: DemoScreen(),
    );
  }
}

