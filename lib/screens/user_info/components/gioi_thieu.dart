import 'package:app_menh_ly/constants.dart';
import 'package:flutter/material.dart';

class GioiThieu extends StatelessWidget {
  const GioiThieu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textQuy =
        'Không chỉ có bề ngoài bình tĩnh và khá nhẹ nhàng, bạn là một người hướng nội với đời sống nội tâm phong phú. Hơn nữa, bạn còn là người nắm bắt tâm lý tốt và luôn nói lời nhỏ nhẹ nên đc mọi người yêu mến.';
    final textCachCuc =
        'Thuộc Tỷ Kiếp cách, sự thông minh của bạn nằm ở cách ứng xử khéo léo và giải quyết các vấn đề một cách thoả đáng. Cộng với phản xạ nhạy bén giúp bạn làm chủ các cuộc đàm phám, thương thảo.';
    final textThanVuong =
        'Là người mang thân Vượng, bạn có tiềm năng trở thành một nhà lãnh đạo tài giỏi, ngay cả khi bạn không nhận ra điều đó. Chính sự quyết đoán và bản lĩnh sẽ giúp bạn có thể tự đứng vững trên đôi chân và tạo lập sự nghiệp của riêng mình.';
    final textDaoHoa =
        'Bạn sẽ cảm thấy dễ có tình cảm với những người có năm, tháng, ngày giờ sinh rơi vào địa chi Ngọ.';
    final textQuyNhan =
        'Bạn sẽ được sự giúp đỡ nếu gặp người có năm, tháng, ngày, giờ sinh rơi vào địa chi Mão và Tỵ.';
    Widget buildText(text) => RichText(
          text: TextSpan(text: text, style: TextStyle(height: 1.5)),
        );
    Widget buildHeader(
            {required String header,
            required Function() press,
            String btnTitle = 'Thông tin'}) =>
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${header.toUpperCase()}",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              WidgetSpan(
                child: IconButton(
                  onPressed: press,
                  icon: Icon(
                    Icons.info,
                    color: Colors.white.withOpacity(0.6),
                    size: 18,
                  ),
                  tooltip: btnTitle,
                ),
                alignment: PlaceholderAlignment.middle,
              ),
            ],
          ),
          textScaleFactor: 1.125,
        );
    void showChiTiet(context, {required String title, required String text}) {
      showGeneralDialog(
        barrierLabel: "Label",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 300),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
                minWidth: MediaQuery.of(context).size.width,
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(kDefaultPadding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black, height: 1.4),
                          children: [
                            TextSpan(
                              text: title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            WidgetSpan(
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: kDefaultPadding,
                                    bottom: kDefaultPadding),
                                decoration: BoxDecoration(
                                  border:
                                      Border(bottom: BorderSide(width: 0.5)),
                                ),
                              ),
                            ),
                            TextSpan(text: text),
                            WidgetSpan(
                              child: Container(
                                padding: EdgeInsets.all(kDefaultPadding / 3),
                                margin: EdgeInsets.only(top: 20),
                                width: double.infinity,
                                color: Colors.green,
                                child: TextButton(
                                  child: Text(
                                    'ĐÓNG',
                                    style: TextStyle(color: Colors.white),
                                    textScaleFactor: 1.3,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position:
                Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
            child: child,
          );
        },
      );
    }

    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.grey.shade900.withOpacity(0.7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(
            header: "NHẬT CHỦ QUÝ Thủy",
            press: () => showChiTiet(context,
                title: 'Nhật Chủ',
                text:
                    'Thời gian sinh của mỗi người bao gồm bốn yếu tố: năm, tháng, ngày, giờ tương ứng được gọi là niên trụ, nguyệt trụ, nhật trụ và thời trụ và được gọi chung là Tứ Trụ. Mỗi trụ được phân thành Thiên can và Địa chi. Thiên can gồm có: Giáp, Ất, Bính, Đinh, Mậu, Kỷ, Canh, Tân, Nhâm, Quý, Địa chi gồm có: Dần, Mão, Thìn, Tỵ, Ngọ, Mùi, Thân, Dậu, Tuất, Hợi, Tý, Sửu.\nCổ nhân qua nhiều năm chiêm nghiệm và nhận thấy Tứ trụ có liên quan mật thiết đến vận mệnh của đời người và đã thống kê xây dựng thành bộ môn Tứ trụ học luận đoán cuộc đời và tính cách con người. Trong đó, Nhật trụ là gốc rễ của Tự trụ học, tất cả tính cách, vận mệnh con người là sự phân tích đánh giá giữa Nhật trụ với các trụ còn lại.'),
          ),
          buildText(textQuy),
          buildHeader(
            header: "cách cục",
            press: () => showChiTiet(context,
                title: 'Cách Cục',
                text:
                    'Mỗi người có năm, tháng, ngày, giờ sinh ở trạng thái khác nhau của vũ trụ nên thừa hưởng các dạng năng lượng khác nhau, vượng suy khác nhau do đó người sinh ra có hoạ phúc, phú quý khác nhau cuối cùng hình thành nên số mệnh. Cách cục là một trong những phương pháp quan trọng trong Tứ trụ học, thông qua thống kê từ hàng triệu trường hợp dựa trên để đưa ra thông số phản ánh tính cách của con người.'),
          ),
          buildText(textCachCuc),
          buildHeader(
            header: "Thân vượng",
            press: () => showChiTiet(context,
                title: 'Vượng Nhược của Nhật Chủ',
                text:
                    'Dân gian thường nói "có số làm quan". Vậy cơ sở đâu để đánh giá người đó có mệnh làm quan ? Câu trả lời nằm ở tính toán Thân Vượng hay Thân Nhược dựa trên việc so sánh Thiên can của Nhật trụ với các yếu tố thuận nghịch ngũ hành khác có trong Tứ trụ. Qua đó, chúng ta sẽ hiểu được khả năng, phương thức giao tiếp và xu hướng giải quyết các vấn đề trong cuộc sống của một người.'),
          ),
          buildText(textThanVuong),
          buildHeader(
            header: "Đào hoa",
            press: () => showChiTiet(context,
                title: 'Đào Hoa',
                text:
                    'Sao Đào Hoa không hẳn là đa tình, mà ở nghĩa rộng hơn nó là sự thu hút, như một đóa hoa đẹp ai cũng thích. Người có đào hoa của bạn là người bạn sẽ dễ dàng có cảm tình, không nhất thiết là tình cảm nam nữ mà có thể là tình cảm bạn bè, anh em, đồng nghiệp. Bạn thường có xu hướng quý mến thích trò chuyện hoặc công tác, đi chơi cùng người đó '),
          ),
          buildText(textDaoHoa),
          buildHeader(
            header: "Quý nhân",
            press: () => showChiTiet(context,
                title: 'Quý Nhân',
                text:
                    'Quý nhân là tên gọi đơn giản của Thiên Ất Quý nhân, là sao may mắn nhất trong mệnh, tượng trưng cho người hay giúp đỡ người khác. Những người trong Tứ trụ có Địa chi tương ứng là Quý nhân của bạn sẽ hỗ trợ bạn rất nhiều về cuộc sống, công danh hay kiến thức. Họ sẽ là người sẵn lòng hỗ trợ hoặc giúp đỡ cho bạn.'),
          ),
          buildText(textQuyNhan),
        ],
      ),
    );
  }
}
