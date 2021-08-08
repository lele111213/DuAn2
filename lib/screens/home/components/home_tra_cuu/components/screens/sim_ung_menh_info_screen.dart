import 'sim_ung_menh_ket_qua_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimUngMenhInfo extends StatefulWidget {
  const SimUngMenhInfo({Key? key}) : super(key: key);
  @override
  _SimUngMenhInfoState createState() => _SimUngMenhInfoState();
}

class _SimUngMenhInfoState extends State<SimUngMenhInfo> {
  String _phoneNumber = '';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back-ground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            toolbarHeight: 45,
            title: Text(
              'Sim ứng mệnh',
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Giải mã vận mệnh thông qua số điện thoại',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 30),
                  Text('NHẬP SỐ ĐIỆN THOẠI',
                      style: TextStyle(color: Colors.white, height: 1),
                      textScaleFactor: 1.4),
                  SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    maxLength: 12,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.4),
                      focusedBorder: InputBorder.none,
                    ),
                    style: TextStyle(color: Colors.white),
                    onChanged: (input) {
                      setState(() {
                        _phoneNumber = input;
                      });
                    },
                  ),
                  SizedBox(height: 30),
                  Text(
                      'Lưu ý: Kết quả chỉ chính xác khi bản đã sử dụng số điện thoại này trên 5 năm. Và những giai đoạn chưa sử dụng có thể không ứng nghiệm.',
                      style: TextStyle(color: Colors.white, height: 1)),
                  Spacer(),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      onPressed: _phoneNumber.length > 7
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SimUngMenhKetQua(
                                    phoneNumber: _phoneNumber,
                                  ),
                                ),
                              );
                            }
                          : null,
                      child: Text('LUẬN GIẢI'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            _phoneNumber.length > 7
                                ? Colors.green
                                : Colors.grey),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
