import 'package:flutter/material.dart';
import 'package:flutter_features/utils/extensions/widget_extensions.dart';
import 'package:flutter_features/utils/sizes/app_sizes.dart';
import 'package:flutter_features/view/bottom_navigation_bar/bottom_navigation_bar_screen.dart';
import 'package:flutter_features/view/bottom_sheet/bottom_sheet_view.dart';
import 'package:flutter_features/view/media/media_screen.dart';

import 'bottom_navigation_bar/bottom_navigation_bar_view.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flutter Features",
        ),
        actions: [const Icon(Icons.notification_add), 20.width],
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              BottomNavigationBarView(
                items: BottomNavigationBarData.items,
                bodyItems: BottomNavigationBarData.widgets,
              ).launchWidget(context);
            },
            title: const Text("Show Bottom Navigation"),
          ).paddingSymmetric(vertical: 5),
          ListTile(
            onTap: () {
              ShowAppBottomSheetView(context: context)
                  .showSheetFromBottomView();
            },
            title: const Text("Show Bottom Sheet"),
          ).paddingSymmetric(vertical: 5),
          ListTile(
            onTap: () {
              ShowAppBottomSheetView(context: context).showTopModalSheet();
            },
            title: const Text("Show Top Sheet"),
          ).paddingSymmetric(vertical: 5),
          ListTile(
            onTap: () {
              const MediaScreen().launchWidget(context);
            },
            title: const Text("Show Media"),
          ).paddingSymmetric(vertical: 5),
        ],
      ),
    );
  }
}
