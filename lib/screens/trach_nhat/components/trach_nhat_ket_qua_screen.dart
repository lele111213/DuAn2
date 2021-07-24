import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class TrachNhatKetQua extends StatelessWidget {
  const TrachNhatKetQua(
      {Key? key,
      required this.selected,
      required this.gender,
      required this.ngaySinh,
      required this.gioSinh,
      required this.dateRange})
      : super(key: key);
  final DateTimeRange dateRange;
  final int selected;
  final int gender;
  final dynamic ngaySinh;
  final String gioSinh;
  static const Map<int, Map<String, String>> selects = {
    1: {'title': 'Ký Hợp Đồng', 'image': 'assets/images/trach-nhat-ky-hd.jpg'},
    2: {
      'title': 'Khai Trương',
      'image': 'assets/images/trach-nhat-khai-truong.jpg'
    },
    3: {'title': 'Hẹn Hò', 'image': 'assets/images/trach-nhat-hen-ho.webp'},
    4: {'title': 'Động Thổ', 'image': 'assets/images/trach-nhat-dong-tho.jpg'},
    5: {'title': 'Đính Hôn', 'image': 'assets/images/trach-nhat-dinh-hon.jfif'},
    6: {'title': 'Dọn Nhà', 'image': 'assets/images/trach-nhat-don-nha.jfif'},
    7: {'title': 'Đám Cưới', 'image': 'assets/images/trach-nhat-dam-cuoi.jpg'},
    8: {
      'title': 'Thu Tài Sản',
      'image': 'assets/images/trach-nhat-thu-tai-san.jpg'
    }
  };
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double topImgHeight = size.height * 0.3;
    double appBarHeight = 45;
    double boxSizeHeight = size.height * 0.35;
    double boxSizeWidth = size.width * 0.8;

    List<DateTime> getDate() {
      bool cont = true;
      DateTime nextDate = dateRange.start;
      List<DateTime> list = [];
      int max = 5;
      int count = 1;
      while (cont && count < max) {
        if (nextDate.isBefore(dateRange.end) ||
            nextDate.isAtSameMomentAs(dateRange.end)) {
          list.add(nextDate);
          count++;
          nextDate = nextDate.add(Duration(days: 3));
        } else
          cont = false;
      }
      return list;
    }

    List<Widget> buildBox() {
      List<DateTime> values = getDate();
      final random = new Random();
      int r = 0;
      return values
          .map((date) => Container(
                color: Colors.grey.withOpacity(0.3),
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                padding: EdgeInsets.all(10),
                width: boxSizeWidth,
                height: boxSizeHeight,
                child: Column(
                  children: [
                    Text(
                      '${DateFormat('dd/MM/yyyy').format(date)}',
                      style: TextStyle(color: Colors.white),
                      textScaleFactor: 1.2,
                    ),
                    Text(
                      '${r = random.nextInt(18)}h-${r + 2}h',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Ngày này thích hợp với mục địch ${selects[selected]!['title']!.toLowerCase()} trong khoảng thời gian mà bạn đã chọn. bạn nên chuẩn bị cẩn thận mọi thứ. được tiến hành trong suôn sẻ.',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ))
          .toList();
    }

// build
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/back-ground.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            height: topImgHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(selects[selected]!['image']!),
                fit: BoxFit.fill,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      selects[selected]!['title']!.toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Có ${dateRange.end.difference(dateRange.start).inDays ~/ 3 + 1} ngày phù hợp nhất cho bạn',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              toolbarHeight: appBarHeight,
              title: Text(
                'Trạch Nhật',
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: topImgHeight - appBarHeight),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: buildBox(),
                  ),
                ),
                Spacer(),
                Text(
                  'Những ngày trên không phù hợp với bạn?\nHãy thử khoảng thời gian khác',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Chọn lại ngày'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
