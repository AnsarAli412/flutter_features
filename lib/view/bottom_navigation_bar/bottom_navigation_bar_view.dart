import 'package:flutter/material.dart';

class BottomNavigationBarView extends StatefulWidget {
  final List<BottomNavigationBarItem> items;
  final List<Widget> bodyItems;
  const BottomNavigationBarView({Key? key,required this.items, required this.bodyItems}) : super(key: key);

  @override
  State<BottomNavigationBarView> createState() => _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.bodyItems.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(items: widget.items,
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
