import 'package:flutter/material.dart';

class SimUngMenhKetQua extends StatelessWidget {
  const SimUngMenhKetQua({Key? key, required this.phoneNumber})
      : super(key: key);
  final String phoneNumber;

  Widget buildKetQua({
    required BuildContext context,
    required String tuongQue,
    required String yNghia,
    required String tongQuan,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            child: Text(
              tuongQue,
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Ý NGHĨA',
            style: TextStyle(color: Colors.green, height: 1.6),
          ),
          Text(
            yNghia,
            style: TextStyle(color: Colors.white, height: 1.4),
            maxLines: 8,
          ),
          SizedBox(height: 20),
          Text(
            'TỔNG QUAN VỀ SỐ ĐIỆN THOẠI NÀY',
            style: TextStyle(color: Colors.green, height: 1.6),
          ),
          Text(
            tongQuan,
            style: TextStyle(color: Colors.white, height: 1.4),
            maxLines: 8,
          ),
        ],
      );

  Tab _buildTab(
    String title, {
    String? subTitle,
  }) =>
      Tab(
        child: Column(
          children: [
            Text(
              title,
              textScaleFactor: 0.8,
              maxLines: 1,
            ),
            if (subTitle != null)
              Text(
                subTitle,
                textScaleFactor: 0.7,
                maxLines: 1,
                overflow: TextOverflow.fade,
              )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double topImgHeight = size.height * 0.4;

    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      removeLeft: true,
      removeTop: true,
      removeRight: true,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.black87,
          bottomNavigationBar: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('TRA CỨU SỐ KHÁC'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
            ),
          ),
          appBar: AppBar(
            title: Text('Sim ứng mệnh'),
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.popUntil(context,
                        (Route<dynamic> predicate) => predicate.isFirst);
                  },
                  icon: Icon(Icons.close))
            ],
          ),
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: topImgHeight,
                  toolbarHeight: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.none,
                    background: Image.asset(
                      'assets/images/van-thien-1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TabBar(
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.white,
                    indicator: BoxDecoration(border: Border()),
                    labelPadding: EdgeInsets.zero,
                    tabs: [
                      _buildTab('TỔNG QUAN'),
                      _buildTab('TIỀN VẬN', subTitle: 'dưới 22 tuổi'),
                      _buildTab('TRUNG VẬN', subTitle: 'từ 22 - 39 tuổi'),
                      _buildTab('HẬU VẬN', subTitle: 'trên 40 tuổi'),
                    ],
                  ),
                  Text(
                    phoneNumber,
                    style: TextStyle(color: Colors.white),
                    textScaleFactor: 1.4,
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        buildKetQua(
                            context: context,
                            tuongQue: 'Trường cửu chi nghĩa chi tượng',
                            yNghia:
                                'Trên là Chấn(sấm), dưới là Tốn(gió), sấm và gió là động, hễ có sấm sẽ có gió. Quá trình này lặp đi lặp lại, không thay đổi. Vì vậy, tượng quẻ Hằng là tượng lâu dài, vĩnh cửu.',
                            tongQuan:
                                'Ứng với quẻ Lôi Phong Hằng thì số điện thoại này tốt, sấm và gió hỗ trợ nhau, gió càng mạnh sấm càng to, sấm càng to thì gió lại càng lớn Tượng cho sự lâu dài, vĩnh cửu.'),
                        buildKetQua(
                            context: context,
                            tuongQue: 'Phúc lôc đồng tâm chi tượng',
                            yNghia:
                                'Trên là quẻ Tốn(cây), dưới là quẻ Cấn(núi), núi có cây từ dưới thấp lên cao dần là tượng quẻ Tiệm. Quẻ Tiệm tượng tiến lên, nhưng tiến có trình tự, từng bước từng bước một.',
                            tongQuan:
                                'Việc học hành của bạn thời điểm này đang dần được cải thiện, mặc dù chỉ là những dấu hiệu nhỏ. Nhưng kiến thức tích lũy mỗi ngày một ít sẽ là bàn đạp vững cho tương lai của bạn.'),
                        buildKetQua(
                            context: context,
                            tuongQue: 'Môn hộ bất minh chi tượng',
                            yNghia:
                                'Hai quẻ Ly chồng lên nhau, là hai lần sáng, sáng gấp đôi, sáng bên trong, sáng cả bên ngoài. Giống ngọn đuốc soi sáng đường đi phía trước, có ánh sáng thì không sợ bị lạc lối.',
                            tongQuan:
                                'Thời điểm này, công danh và sự nghiệp của bạn đang ở giai đoạn phát triển rực rỡ. Bạn là người dẫn đầu bởi sự sáng tạo đặc sắc. Không những vậy, bạn thường nâng đỡ, định hướng giúp mọi người thành công.'),
                        buildKetQua(
                            context: context,
                            tuongQue: 'Báo ẩn nam sơn chi tượng',
                            yNghia:
                                'Trên là Càn(trời), dưới là Cấn (núi), núi ở dưới trời là tượng quẻ Độn. Dù núi có cao đến đâu cũng không thể cao hơn trời được. Tượng quy ẩn, lùi về tránh thị phi.',
                            tongQuan:
                                'Giai đoạn này bạn muốn quay về ở ẩn, không muốn tranh giành, đặt sự nghiệp xuống nhìn thiên hạ ganh đua tranh giành mà lòng vững vàng. Không xuất hiện, không can thiệp thì cuộc sống mới yên bình.'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
