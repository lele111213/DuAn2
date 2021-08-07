import 'package:flutter/material.dart';
import 'zalo_pay.dart';

class ZaloPayScreen extends StatelessWidget {
  const ZaloPayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back-ground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              toolbarHeight: 45,
              title: Text(
                'Nạp Xu ZaloPay',
              ),
            ),
            body: Container(
              color: Colors.white70,
              child: ZaloPay(),
            ),
          ),
        ),
      ),
    );
  }
}
