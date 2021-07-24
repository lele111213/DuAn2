import 'package:app_menh_ly/constants.dart';
import 'package:flutter/material.dart';

class TraMenhThan extends StatelessWidget {
  const TraMenhThan({Key? key, required this.size, required this.press})
      : super(key: key);
  final Size size;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.fromLTRB(kDefaultPadding / 2, kDefaultPadding,
          kDefaultPadding / 2, kDefaultPadding),
      margin: EdgeInsets.all(kDefaultPadding / 2),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/tra-menh-than.png'),
          fit: BoxFit.cover,
        ),
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 3,
            color: Colors.white,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thấu hiểu một người để\ngắn kết tình thân, cùng\ntìm hiểu họ là ai!',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomLeft,
            child: TextButton(
              onPressed: press,
              child: Text(
                'TRA MỆNH THẦN',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                padding: MaterialStateProperty.all(
                  EdgeInsets.all(kDefaultPadding / 3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
