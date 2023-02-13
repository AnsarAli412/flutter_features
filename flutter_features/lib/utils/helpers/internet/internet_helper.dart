import 'package:flutter/material.dart';
 import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_features/utils/extensions/widget_extensions.dart';
import 'package:flutter_features/utils/helpers/internet/no_internet_view.dart';

 class InternetHelper {

  final _connectivity = Connectivity();
  BuildContext context;

  InternetHelper({required this.context});

  Future<void> checkConnectivityRealTime({required Function(bool status) callBack}) async {
      _connectivity.onConnectivityChanged.listen((result){
      if (result == ConnectivityResult.none) {
        _internetNotAvailableView();
      } else if (result == ConnectivityResult.wifi) {
        finish(context);
        callBack(true);
      } else if (result == ConnectivityResult.mobile) {
        finish(context);
        callBack(true);
      } else {
        _internetNotAvailableView();
      }
    });
  }

  Future<bool> checkConnectivity() async {
    final _connectivity = Connectivity();
    var connectionResult = await _connectivity.checkConnectivity();
    if (connectionResult == ConnectivityResult.none) {
      _internetNotAvailableView();
      return false;
    } else if (connectionResult == ConnectivityResult.wifi) {
      return true;
    } else if (connectionResult == ConnectivityResult.mobile) {
      return true;
    } else {
      _internetNotAvailableView();
      return false;
    }
  }

  _internetNotAvailableView() {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) =>
            NoInternetView()));
  }
 }
