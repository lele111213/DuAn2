import 'package:app_menh_ly/screens/home/components/home_tra_cuu/components/screens/tra_cuu_info_screen.dart';
import 'package:app_menh_ly/screens/home/components/home_tra_cuu/components/tra_cat_nhan.dart';
import 'package:app_menh_ly/screens/home/components/home_tra_cuu/components/tra_menh_than.dart';
import 'package:flutter/material.dart';

class TraCuuKetQua extends StatelessWidget {
  const TraCuuKetQua({
    Key? key,
    required this.selected,
    required this.gender,
    required this.ngaySinh,
    required this.gioSinh,
  }) : super(key: key);
  final int selected;
  final int gender;
  final dynamic ngaySinh;
  final String gioSinh;
  static const Map<int, Map<String, String>> selects = {
    1: {'title': 'Tra Cát Nhân', 'image': 'assets/images/trach-nhat-ky-hd.jpg'},
    2: {'title': 'Tra Đào Hoa', 'image': 'assets/images/tra-dao-hoa.jpg'},
    3: {'title': 'Tra Mệnh Thần', 'image': 'assets/images/tra-menh-than.png'},
    4: {'title': 'Tra Quý Nhân', 'image': 'assets/images/tra-quy-nhan.jfif'},
    5: {'title': 'Sim Ứng Mệnh', 'image': 'assets/images/sim-ung-menh.jpg'}
  };
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double topImgHeight = size.height * 0.4;
    return Scaffold(
      backgroundColor: Colors.black87,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.grey,
              pinned: true,
              expandedHeight: topImgHeight,
              title: Text(selects[selected]!['title']!),
              toolbarHeight: 45,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.popUntil(context,
                          (Route<dynamic> predicate) => predicate.isFirst);
                    },
                    icon: Icon(Icons.close))
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  selects[selected]!['image']!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(10),
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.white, height: 1.4),
              children: [
                TextSpan(
                  text:
                      '${selects[selected]!['title']!}. Đối phương không phải là người bạn tìm kiếm hôm nay. Có thể đối phương vẫn muốn quan tâm giúp đỡ bạn nhưng do mang năng lượng bạn không cần, hai người sẽ dễ nảy sinh tranh luận hoặc có quan điểm khác nhau trong công việc và cuộc sống ngày hôm nay. Tuy nhiên quan điểm chỉ đơn giản là góc nhìn, điều này vẫn sẽ không ảnh hưởng đến mối quan hệ của hai người nếu bạn biết điểm dừng và bình tâm trong tất cả các tranh luận.\n\n',
                ),
                TextSpan(
                  text:
                      'Người bạn này luôn mang sự cuốn hút mà bạn khó có thể lý giải được. Đặc biệt là việc trò chuyện về công việc hay gia đình đều mang đến cảm giác ấm áp, thân thiện và rất hợp lý với nhau. Điều này là do đối phương có Địa Chi năm và tháng sinh rơi vào cung Đào Hoa của bạn, nguồn năng lượng này giúp bạn cảm thấy thư thái khi ở cạnh người bạn này.\n\nHai bạn có thể quen biết do gia đình, người thân giới thiệu hoặc môi trường làm việc chung sẽ giúp bạn dễ có cảm tình với đối phương hơn. Đặc biệt, nếu như là người khác giới, bạn rất dễ có tình cảm xa hơn với họ.\n',
                ),
                if (selected <= 2)
                  WidgetSpan(
                    child: TraMenhThan(
                      size: size,
                      press: () {
                        Navigator.popUntil(context,
                            (Route<dynamic> predicate) => predicate.isFirst);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TraCuuInfo(selected: 3),
                          ),
                        );
                      },
                    ),
                  )
                else
                  WidgetSpan(
                    child: TraCatNhan(
                      size: size,
                      press: () {
                        Navigator.popUntil(context,
                            (Route<dynamic> predicate) => predicate.isFirst);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TraCuuInfo(selected: 1),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
