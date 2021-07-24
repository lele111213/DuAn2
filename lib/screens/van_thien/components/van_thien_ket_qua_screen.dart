import 'package:flutter/material.dart';

class VanThienKetQua extends StatelessWidget {
  const VanThienKetQua({Key? key, required this.selected}) : super(key: key);
  final int selected;
  static const Map<int, Map<String, String>> selects = {
    1: {'title': 'Sức Khỏe', 'image': 'assets/images/van-thien-1.jpg'},
    2: {'title': 'Tài Vận', 'image': 'assets/images/van-thien-1.jpg'},
    3: {'title': 'Tình Cảm', 'image': 'assets/images/van-thien-2.jpg'},
    4: {'title': 'Công Việc', 'image': 'assets/images/van-thien-2.jpg'},
    5: {'title': 'Gia Đình', 'image': 'assets/images/van-thien-3.webp'}
  };
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double topImgHeight = size.height * 0.5;
    return Scaffold(
      backgroundColor: Colors.black87,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.grey,
              pinned: true,
              expandedHeight: topImgHeight,
              title: Text('Vấn Thiên'),
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
          child: Column(
            children: [
              Text(
                selects[selected]!['title']!.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textScaleFactor: 1.2,
              ),
              SizedBox(height: 10),
              Text(
                'Thượng hạ mông lung chi tượng',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.white, height: 1.6),
                    children: [
                      TextSpan(
                        text: 'Ý NGHĨA\n',
                        style: TextStyle(color: Colors.green),
                      ),
                      TextSpan(
                        text:
                            'Nội quái là quẻ Cấn(Thổ), ngoại quái là quẻ Khôn(Thổ). Ngoại quái hỗ trợ nội quái. Tượng Khiêm khi bàn về sức khỏe lại mang ý nghĩa là bạn đang có nhiều bệnh tật bên trong mình. Quẻ Cấn còn tượng trưng cho móng chân, móng tay, lưng hoặc có liên quan đến dạ dày.\n\n',
                      ),
                      TextSpan(
                        text: 'LUẬN GIẢI\n',
                        style: TextStyle(color: Colors.green),
                      ),
                      TextSpan(
                        text:
                            'Nguyệt lệnh thuộc hành Thổ, Thổ vượng lại không tốt đối với nội quái. Sức khỏe bạn không quá kém, nhưng lại phải chịu đựng những cơn đau lưng. Chưa kể bên trong cơ thể những cơn đau dạ dày cũng hoành hành. Hiện tại, bạn cần nghỉ ngơi để điều chỉnh lại cơ thể.\n\n',
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('HỎI VẤN ĐỀ KHÁC'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
