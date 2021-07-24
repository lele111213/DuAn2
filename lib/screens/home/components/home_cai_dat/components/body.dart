import 'package:app_menh_ly/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isSwitched = false;
  void _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/back-ground.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  Text(
                    'Quay lại trang nhập thông tin người dùng.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10)),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.green),
                    ),
                    onPressed: () {
                      _logOut();
                      user!.logout();
                    },
                    child: Text(
                      'QUAY LẠI',
                      textScaleFactor: 0.8,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.grey[900],
                child: Column(
                  children: [
                    buildButton(
                      title: 'Đánh giá ứng dụng',
                      icon: Icons.star_outline,
                    ),
                    buildButton(
                      title: 'Vì sao có quảng cáo',
                      icon: Icons.pause_presentation_outlined,
                    ),
                    buildButton(
                      title: 'Về chúng tôi',
                      icon: Icons.info_outline,
                    ),
                    buildButton(
                      title: 'Gửi phản hồi',
                      icon: Icons.mail_outline,
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'TIỆN ÍCH',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 0.1, color: Colors.white),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.notifications_none,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Thông báo hằng ngày',
                            style: TextStyle(color: Colors.white),
                          ),
                          Spacer(),
                          Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                              });
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildButton({required String title, required IconData icon}) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.transparent),
      ),
      onPressed: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.1, color: Colors.white),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
