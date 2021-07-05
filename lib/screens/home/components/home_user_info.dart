import 'package:app_menh_ly/components/tinh_ngay.dart';
import 'package:app_menh_ly/constants.dart';
import 'package:app_menh_ly/models/user.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeInfoUser extends StatelessWidget {
  const HomeInfoUser({Key? key, required this.size, required this.press})
      : super(key: key);
  final Size size;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context)!;
    final born = user.birthDay;
    return Container(
      height: 130 < size.height * 0.2 ? size.height * 0.2 : 130,
      padding: EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/back-ground-user.jpg'),
          fit: BoxFit.cover,
        ),
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
          IconButton(
            iconSize: 70,
            onPressed: press,
            icon: ClipOval(
              child: Image.asset(
                'assets/images/default.jpg',
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(left: kDefaultPadding)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${user.userName}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  textScaleFactor: 1.1,
                ),
                Text(
                  '${DateFormat('dd-MM-yyyy').format(born)}\nNgày ${TinhCanChi.tinhNgayCanChi(born)}\nTháng ${TinhCanChi.tinhThangCanChi(born)}, Năm ${TinhCanChi.tinhNamCanChi(born)}',
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
