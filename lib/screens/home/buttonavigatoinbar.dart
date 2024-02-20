import 'package:chokchey_finance/utils/storages/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/module/home_new/screen/new_homescreen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _isSelect = 0;
  List listpage = [
    NewHomeScreen(),
    NewHomeScreen(),
    NewHomeScreen(),
  ];
  _changeTab(int index) {
    setState(() {
      _isSelect = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listpage[_isSelect],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: logolightGreen,
        currentIndex: _isSelect,
        onTap: (index) => _changeTab(index),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svg/home.svg",
                height: 36,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svg/plus.svg",
                height: 36,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/svg/star.svg",
                height: 36,
              ),
              label: ""),
        ],
      ),
    );
  }
}
