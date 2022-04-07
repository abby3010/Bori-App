// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, avoid_unnecessary_containers, unused_local_variable, use_key_in_widget_constructors, unnecessary_this

import 'package:bori_app/themes/AppColors.dart';
import 'package:bori_app/view/screens/AboutScreen.dart';
import 'package:bori_app/view/screens/AdmissionScreen.dart';
import 'package:flutter/material.dart';

import 'MiddleScreen.dart';

class MainActivityAdmission extends StatefulWidget {
  @override
  _BottomBarState createState() => new _BottomBarState();
}

class _BottomBarState extends State<MainActivityAdmission> {
  late int _pageIndex = 0;
  late PageController _pageController;

  List<Widget> tabPages = [AdmissionScreen(), MiddleScreen(), AboutScreen()];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.more_bg,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      // if(_pageIndex==2)
      //   {
      //     tabPages.insert(2, MoreScreen());
      //   }
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    // if(index==2)
    //   {
    //     tabPages.insert(2, MoreScreen());
    //   }
  }

  Widget showIndicator(bool show) {
    return show
        ? Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Icon(Icons.line_weight, size: 10, color: Colors.orange),
          )
        : SizedBox();
  }
}
