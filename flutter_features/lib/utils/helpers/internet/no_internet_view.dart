import 'package:flutter/material.dart';

import 'internet_helper.dart';

class NoInternetView extends StatefulWidget {
  const NoInternetView({Key? key}) : super(key: key);

  @override
  State<NoInternetView> createState() => _NoInternetViewState();
}

class _NoInternetViewState extends State<NoInternetView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("No internet"),
      ),
    );
  }
}
