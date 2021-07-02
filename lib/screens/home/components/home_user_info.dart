import 'package:app_menh_ly/constants.dart';
import 'package:flutter/material.dart';

class HomeInfoUser extends StatelessWidget {
  const HomeInfoUser({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: EdgeInsets.only(bottom: kDefaultPadding),
      padding: EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      decoration: BoxDecoration(
        // image: DecorationImage(image: AssetImage('')),
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 5,
            color: kPrimaryColor.withOpacity(0.9),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          // Container(
          //   margin: EdgeInsets.only(right: kDefaultPadding),
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       fit: BoxFit.contain,
          //       image: AssetImage('assets/images/default.jpg'),
          //     ),
          //     shape: BoxShape.circle,
          //   ),
          //   width: 70,
          //   height: 70,
          // ),

          ClipOval(
            child: Image.asset(
              'assets/images/default.jpg',
              width: 70,
            ),
          ),

          Padding(padding: EdgeInsets.only(left: kDefaultPadding)),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Lanmm',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  '9/8/1999\nNgày Quý Tỵ\nTháng Nhâm Thân, Năm Kỷ Mão',
                  textScaleFactor: 0.8,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
