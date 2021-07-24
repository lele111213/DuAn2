import 'package:app_menh_ly/components/tinh_ngay.dart';
import 'package:app_menh_ly/constants.dart';
import 'package:app_menh_ly/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context)!;
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey.shade900.withOpacity(0.9),
            Colors.transparent,
            Colors.grey.shade900.withOpacity(0.9),
          ],
          tileMode: TileMode.mirror,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              'assets/images/default.jpg',
              width: 70,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.userName}',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${DateFormat('dd-MM-yyyy').format(user.birthDay)}\nNgày ${TinhCanChi.tinhNgayCanChi(user.birthDay)}\nTháng ${TinhCanChi.tinhThangCanChi(user.birthDay)}, Năm ${TinhCanChi.tinhNamCanChi(user.birthDay)}',
                  style: TextStyle(color: Colors.white),
                  // overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
