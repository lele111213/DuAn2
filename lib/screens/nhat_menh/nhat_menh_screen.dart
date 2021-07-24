import 'components/tab-nhat-menh.dart';
import 'package:flutter/material.dart';

class NhatMenhScreen extends StatefulWidget {
  const NhatMenhScreen({Key? key}) : super(key: key);

  @override
  _NhatMenhScreenState createState() => _NhatMenhScreenState();
}

class _NhatMenhScreenState extends State<NhatMenhScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double _appBarSize = size.height * 0.4;
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.grey,
                  pinned: true,
                  expandedHeight: _appBarSize,
                  title: Text('Nhật Mệnh'),
                  toolbarHeight: 45,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      'assets/images/nhat-menh-app-bar.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  bottom: TabBar(
                    indicatorColor: Colors.transparent,
                    controller: _tabController,
                    onTap: (index) => {
                      if (_appBarSize - _scrollController.offset < 93)
                        {_scrollController.jumpTo(_appBarSize - 93)},
                      setState(() {})
                    },
                    tabs: [
                      Tab(
                        icon: Image.asset(
                          'assets/icons/lucky-4-leaf.png',
                          width: _tabController.index == 0 ? 45 : 30,
                        ),
                      ),
                      Tab(
                        icon: Image.asset(
                          'assets/icons/lucky-4-leaf.png',
                          width: _tabController.index == 1 ? 45 : 30,
                        ),
                      ),
                      Tab(
                        icon: Image.asset(
                          'assets/icons/lucky-4-leaf.png',
                          width: _tabController.index == 2 ? 45 : 30,
                        ),
                      ),
                      Tab(
                        icon: Image.asset(
                          'assets/icons/lucky-4-leaf.png',
                          width: _tabController.index == 3 ? 45 : 30,
                        ),
                      )
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                TabNhatMenh(
                  title: 'Tình Cảm Lứa Đôi',
                  vanDe:
                      'Trong người đang bực mình, cộng thêm sự khó hiểu của con gái, nên hôm nay giữa bạn và nàng có thể sẽ xảy ra chiến tranh.\n\nQuan trọng, mỗi người một ý chẳng ai chịu ai, thế là mọi chuyện theo đó đi xa.',
                  hoaGiai:
                      'Hoặc ngồi lại lắng nghe nhau nói, hoặc cho nhau thời gian để bình tâm. Không yêu đừng nói lời tổn thương, và đã yêu thì lại càng phải bình tĩnh để không xát muối vào tim nàng.\n\nKhông dừng lại ở đó, mâu thuẫn đôi bên có thể sẽ còn gay gắt hơn, bởi lẽ hôm nay lượng Mộc không đủ đã tác động lên mối quan hệ của bạn những năng lượng tiêu cực.\n\nDành ra ít phút đi dạo công viên sẽ giúp bạn reset lại bản thân, cũng như cân bằng lại lượng ngũ hành. Khi đó, "nghiệp" của bạn cũng ít đi phần nào.\n\nThời điểm tốt nhất để nói chuyện với nhau là 9h - 11h sẽ giúp bạn giảm bớt những yếu tố đối nghịch với bản thân.',
                  percent: 40,
                ),
                TabNhatMenh(
                  title: 'Sức khoẻ tinh thần',
                  vanDe:
                      'Dường như tinh thần bạn hôm nay không được tốt. Các yếu tố từ công việc, tiền bạc đến những mối quan hệ xung quanh giống như tảng đá nặng đè lên đôi vai bạn.',
                  hoaGiai:
                      'Một nơi yên tĩnh để thư giãn và bình tâm, sẽ là lựa chọn tốt cho bạn ngày hôm nay. Cùng với đó, hãy lên cho mình những thực đơn cùng một chế độ luyện tập hợp lý nhé.\n\nTuy nhiên, dù ngày mới rất tốt hay u ám thì việc thiếu năng lượng Mộc sẽ ít nhiều khiến sức khoẻ của bạn "già" đi.\n\n Thế nên, để níu kéo sự trẻ - khoẻ của mình, bạn có thể lấp đầy năng lượng còn thiếu bằng những món ăn có vị chua. Ví dụ món canh gân bò hầm cải chua sẽ là gợi ý cho bữa cơm hôm nay của bạn.',
                  percent: 20,
                ),
                TabNhatMenh(
                  title: 'Sức Khoẻ Thể Chất',
                  vanDe:
                      'Hôm nay trông bạn cứ như một ông cụ, tư duy không chậm chạp thì tại cũng nghe câu được câu mất.\n\nNguyên nhân là do sức khỏe của bạn đang "già" đi, và có khả năng mắc phải những bệnh liên quan đến thận, máu hoặc tủy sống.',
                  hoaGiai:
                      'Có sức khỏe mới có tất cả, vì vậy hãy dành thời gian ghé bác sĩ khi bạn phát hiện dấu hiệu bất thường.\n\nĐặc biệt, một thời gian biểu hợp lý cho việc ăn uống tập luyện cũng giúp bạn bảo vệ sức khỏe của mình.\n\nTuy nhiên , dù ngày mới rất tốt hay u ám thì việc thiếu năng lượng Mộc sẽ ít nhiều khiến sức khỏe của bạn "già" đi.\n\nThế nên, để níu kéo sự trẻ-khỏe của mình, bạn có thể lấp đầy năng lượng còn thiếu bằng những món ăn có vị chua. Ví dụ, món canh gân bò hầm cải chua sẽ là gợi ý cho bữa cơm hôm nay của',
                  percent: 70,
                ),
                TabNhatMenh(
                  title: 'Phẫu Thuật Ngoại Khoa',
                  vanDe:
                      'Sức khỏe của bạn hôm nay có dấu hiệu suy yếu. Một số bệnh tiềm ẩn khả năng cao sẽ trỗi dậy và "quật" bạn. Hơn nữa, nếu bạn thực hiện các cuộc phẫu thuật trong ngày này có thể sẽ xảy ra nhiều sai sót.',
                  hoaGiai:
                      'Hôm nay, bạn nên đặc biệt chú ý đến sức khỏe của mình. Nếu tình trạng sức khỏe vẫn đang trong tầm kiểm soát, thì bạn nên hạn chế các hoạt động can thiệp vào cơ thể.\n\nThay vào đó, hãy tự bồi bổ bản thân với những món ăn yêu thích.\n\nThế nhưng, việc thiếu năng lượng Mộc đôi lúc sẽ khiến bạn có cảm giác Cơ thể như đang đi mượn dù ngày mới tốt hay xấu.\n\nVì vậy, để cân bằng lại ngũ hành bạn nên thêm vào thực đơn những món ăn có vị chua. Chẳng hạn một ly nước cam siêu to khổng lồ sẽ giúp bạn tràn đầy năng lượng.',
                  percent: 90,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
