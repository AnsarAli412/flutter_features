
import 'package:flutter/material.dart';
import 'package:flutter_features/utils/shapes/app_shapes.dart';
import 'package:flutter_features/utils/sizes/app_sizes.dart';

class ShowAppBottomSheetView{
  BuildContext context;
  ShowAppBottomSheetView({required this.context});

  Future<T?> showSheetFromBottomView<T>({Widget? child,bool isExpended = false}){
    var height = screenHeight(context);
    var width = screenWidth(context);
    return showModalBottomSheet(
      isScrollControlled: isExpended,
      elevation: 10,
      shape: topLeftRightShape(borderRadius: 26.0,borderSize: 0.0),
        context: context, builder: (c){
      return child??SizedBox(
        height: height/2,
        width: width,
      );
    });
  }

  Future<T?> showTopModalSheet<T>(
      {bool barrierDismissible = true,Widget? child}) {
    return showGeneralDialog<T?>(
      context: context,
      barrierDismissible: barrierDismissible,
      transitionDuration: const Duration(milliseconds: 250),
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, _, __) => child??SizedBox(
        height: screenHeight(context)/2,
        width: screenWidth(context),
        child: const Center(child: Text("Top Sheet")),
      ),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)
              .drive(
              Tween<Offset>(begin: const Offset(0, -1.0), end: Offset.zero)),
          child: SafeArea(
            child: Column(
              children: [
                Material(
                  elevation: 5,
                  shape: bottomLeftRightShape(borderRadius: 20.0,borderSize: 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [child],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

}