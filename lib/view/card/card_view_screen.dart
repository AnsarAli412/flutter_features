import 'package:flutter/material.dart';
import 'package:flutter_features/utils/extensions/widget_extensions.dart';
import 'package:flutter_features/utils/sizes/app_sizes.dart';

class CardViewScreen extends StatelessWidget {
  const CardViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cards"),
      ),
      body: ListView.builder(
        itemCount: 5,
          itemBuilder: (context, index) {
        return Card(
          child: SizedBox(
            height: 100.0 * index,
            width: screenWidth(context),
            child: Text("Card Number $index"),
          ),
        ).paddingAll(10);
      }),
    );
  }
}
