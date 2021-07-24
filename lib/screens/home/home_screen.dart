import 'package:flutter/material.dart';

import 'components/body.dart';
import 'components/home_cai_dat/cai_dat_screen.dart';
import 'components/home_tra_cuu/tra_cuu_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Body(),
            TraCuuScreen(),
            CaiDatScreen(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: PreferredSize(
            preferredSize: Size.fromHeight(10),
            child: TabBar(
              indicatorColor: Colors.transparent,
              onTap: (index) {
                setState(() {
                  _tabIndex = index;
                });
              },
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.home_outlined,
                    color: _tabIndex == 0 ? Colors.green : Colors.white,
                  ),
                  child: Text(
                    'Trang chủ',
                    style: TextStyle(
                        color: _tabIndex == 0 ? Colors.green : Colors.white),
                  ),
                  iconMargin: EdgeInsets.zero,
                ),
                Tab(
                  icon: Icon(
                    Icons.person_outline,
                    color: _tabIndex == 1 ? Colors.green : Colors.white,
                  ),
                  child: Text(
                    'Tra cứu',
                    style: TextStyle(
                        color: _tabIndex == 1 ? Colors.green : Colors.white),
                  ),
                  iconMargin: EdgeInsets.zero,
                ),
                Tab(
                  icon: Icon(
                    Icons.settings_outlined,
                    color: _tabIndex == 2 ? Colors.green : Colors.white,
                  ),
                  child: Text(
                    'Cài đặt',
                    style: TextStyle(
                        color: _tabIndex == 2 ? Colors.green : Colors.white),
                  ),
                  iconMargin: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
