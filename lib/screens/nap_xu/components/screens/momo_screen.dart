import 'package:app_menh_ly/screens/nap_xu/components/screens/momo.dart';
import 'package:flutter/material.dart';

class MomoScreen extends StatelessWidget {
  const MomoScreen({Key? key}) : super(key: key);

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
                'Nạp Xu Ví Momo',
              ),
            ),
            body: Container(
              color: Colors.white70,
              child: Momo(),
            ),
          ),
        ),
      ),
    );
  }
}
