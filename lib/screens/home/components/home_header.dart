import 'package:app_menh_ly/constants.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: kDefaultPadding / 2, top: kDefaultPadding),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          shadows: [Shadow(color: Colors.white, blurRadius: 10.0)],
          fontWeight: FontWeight.bold,
        ),
        textScaleFactor: 1.2,
      ),
    );
  }
}
