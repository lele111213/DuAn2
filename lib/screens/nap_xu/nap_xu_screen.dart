import 'package:app_menh_ly/screens/nap_xu/components/screens/dashboard.dart';
import 'package:flutter/material.dart';

class NapXuScreen extends StatelessWidget {
  const NapXuScreen({Key? key}) : super(key: key);

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
                'Nạp Xu',
              ),
            ),
            body: Container(
              color: Colors.white70,
              child: DashBoard(),
            ),
          ),
        ),
      ),
    );
  }
}
