import 'package:app_menh_ly/screens/nhat_menh/components/htdn-tab.dart';
import 'package:app_menh_ly/screens/nhat_menh/components/htnn-tab.dart';
import 'package:app_menh_ly/screens/nhat_menh/components/pv-nc-tab.dart';
import 'package:app_menh_ly/screens/nhat_menh/components/tttt-tab.dart';
import 'package:flutter/material.dart';

class NhatMenhScreen extends StatefulWidget {
  const NhatMenhScreen({Key? key}) : super(key: key);

  @override
  _NhatMenhScreenState createState() => _NhatMenhScreenState();
}

class _NhatMenhScreenState extends State<NhatMenhScreen> {
  int _currentTabIndex = 0;
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/user-info.jfif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: DefaultTabController(
            length: 4,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.grey,
                  pinned: true,
                  expandedHeight: size.height * 0.4,
                  title: Text('Nhật Mệnh'),
                  toolbarHeight: 45,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      'assets/images/nhat-menh-app-bar.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  bottom: TabBar(
                    isScrollable: true,
                    onTap: (index) => {
                      if (_currentTabIndex != index)
                        {
                          if (_scrollController.offset > 120)
                            {_scrollController.jumpTo(120)},
                          setState(() {
                            _currentTabIndex = index;
                          })
                        }
                    },
                    tabs: [
                      Tab(
                        icon: Image.asset(
                          'assets/icons/lucky-4-leaf.png',
                          width: _currentTabIndex == 0 ? 45 : 30,
                        ),
                      ),
                      Tab(
                        icon: Image.asset(
                          'assets/icons/lucky-4-leaf.png',
                          width: _currentTabIndex == 1 ? 45 : 30,
                        ),
                      ),
                      Tab(
                        icon: Image.asset(
                          'assets/icons/lucky-4-leaf.png',
                          width: _currentTabIndex == 2 ? 45 : 30,
                        ),
                      ),
                      Tab(
                        icon: Image.asset(
                          'assets/icons/lucky-4-leaf.png',
                          width: _currentTabIndex == 3 ? 45 : 30,
                        ),
                      )
                    ],
                  ),
                ),
                SliverFillRemaining(
                  child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        PhongVanNghienCuuTab(),
                        HanhTrinhNganNgayTab(),
                        HanhTrinhDaiNgayTab(),
                        ThuTucThongThuongTab(),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
