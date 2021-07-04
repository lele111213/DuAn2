import 'dart:math';

/*
Algorithms for computing lunar calendar by timezone
 */
class CalendarConverter {
  //INT(x) để lấy số nguyên lớn nhất không vượt quá x
  static int toInt(double value) {
    return value.floor();
  }

  //Chuyển đổi ngày tháng năm -> số ngày Julius
  static int jdFromDate(int dd, int mm, int yy) {
    var a, y, m, jd;
    a = toInt((14 - mm) / 12);
    y = yy + 4800 - a;
    m = mm + 12 * a - 3;
    jd = dd +
        toInt((153 * m + 2) / 5) +
        365 * y +
        toInt(y / 4) -
        toInt(y / 100) +
        toInt(y / 400) -
        32045;
    if (jd < 2299161) {
      jd = dd + toInt((153 * m + 2) / 5) + 365 * y + toInt(y / 4) - 32083;
    }
    return jd;
  }

  //Chuyển đổi số ngày Julius -> ngày tháng năm
  static DateTime jdToDate(int jd) {
    var a, b, c, d, e, m, day, month, year;
    if (jd > 2299160) {
      // After 5/10/1582, Gregorian calendar
      a = jd + 32044;
      b = toInt((4 * a + 3) / 146097);
      c = a - toInt((b * 146097) / 4);
    } else {
      b = 0;
      c = jd + 32082;
    }
    d = toInt((4 * c + 3) / 1461);
    e = c - toInt((1461 * d) / 4);
    m = toInt((5 * e + 2) / 153);
    day = e - toInt((153 * m + 2) / 5) + 1;
    month = m + 3 - 12 * toInt(m / 10);
    year = b * 100 + d - 4800 + toInt(m / 10);
    DateTime result = new DateTime(year, month, day);
    return result;
  }

  //Tính ngày Sóc thứ k kể từ điểm Sóc ngày 1/1/1900.
  //Kết quả trả về là số ngày Julius của ngày Sóc cần tìm
  static int getNewMoonDay(int k, int timeZone) {
    var T, T2, T3, dr, Jd1, M, Mpr, F, C1, deltat, JdNew;
    T = k / 1236.85; // Time in Julian centuries from 1900 January 0.5
    T2 = T * T;
    T3 = T2 * T;
    dr = pi / 180;
    Jd1 = 2415020.75933 + 29.53058868 * k + 0.0001178 * T2 - 0.000000155 * T3;
    Jd1 = Jd1 +
        0.00033 *
            sin((166.56 + 132.87 * T - 0.009173 * T2) * dr); // Mean new moon
    M = 359.2242 +
        29.10535608 * k -
        0.0000333 * T2 -
        0.00000347 * T3; // Sun's mean anomaly
    Mpr = 306.0253 +
        385.81691806 * k +
        0.0107306 * T2 +
        0.00001236 * T3; // Moon's mean anomaly
    F = 21.2964 +
        390.67050646 * k -
        0.0016528 * T2 -
        0.00000239 * T3; // Moon's argument of latitude
    C1 = (0.1734 - 0.000393 * T) * sin(M * dr) + 0.0021 * sin(2 * dr * M);
    C1 = C1 - 0.4068 * sin(Mpr * dr) + 0.0161 * sin(dr * 2 * Mpr);
    C1 = C1 - 0.0004 * sin(dr * 3 * Mpr);
    C1 = C1 + 0.0104 * sin(dr * 2 * F) - 0.0051 * sin(dr * (M + Mpr));
    C1 = C1 - 0.0074 * sin(dr * (M - Mpr)) + 0.0004 * sin(dr * (2 * F + M));
    C1 = C1 - 0.0004 * sin(dr * (2 * F - M)) - 0.0006 * sin(dr * (2 * F + Mpr));
    C1 = C1 +
        0.0010 * sin(dr * (2 * F - Mpr)) +
        0.0005 * sin(dr * (2 * Mpr + M));
    if (T < -11) {
      deltat = 0.001 +
          0.000839 * T +
          0.0002261 * T2 -
          0.00000845 * T3 -
          0.000000081 * T * T3;
    } else {
      deltat = -0.000278 + 0.000265 * T + 0.000262 * T2;
    }
    ;
    JdNew = Jd1 + C1 - deltat;
    return toInt(JdNew + 0.5 + timeZone / 24);
  }

  //Tính tọa độ mặt trời để biết Trung khí nào nằm trong tháng âm lịch nào,
  //Tính xem mặt trời nằm ở khoảng nào trên đường hoàng đạo vào thời điểm bắt đầu một tháng âm lịch:
  //-chia đường hoàng đạo làm 12 phần và đánh số các cung này từ 0 đến 11: từ Xuân phân đến Cốc vũ là 0; từ Cốc vũ đến Tiểu mãn là 1; từ Tiểu mãn đến Hạ chí là 2; v.v..
  //-cho jdn là số ngày Julius của bất kỳ một ngày, phương pháp sau này sẽ trả lại số cung nói trên.
  static int getSunLongitude(jdn, timeZone) {
    var T, T2, dr, M, L0, DL, L;
    T = (jdn - 2451545.5 - timeZone / 24) /
        36525; // Time in Julian centuries from 2000-01-01 12:00:00 GMT
    T2 = T * T;
    dr = pi / 180; // degree to radian
    M = 357.52910 +
        35999.05030 * T -
        0.0001559 * T2 -
        0.00000048 * T * T2; // mean anomaly, degree
    L0 = 280.46645 + 36000.76983 * T + 0.0003032 * T2; // mean longitude, degree
    DL = (1.914600 - 0.004817 * T - 0.000014 * T2) * sin(dr * M);
    DL = DL +
        (0.019993 - 0.000101 * T) * sin(dr * 2 * M) +
        0.000290 * sin(dr * 3 * M);
    L = L0 + DL; // true longitude, degree
    L = L * dr;
    L = L - pi * 2 * (toInt(L / (pi * 2))); // Normalize to (0, 2*PI)
    return toInt(L / pi * 6);
  }

  //Tìm ngày bắt đầu tháng 11 âm lịch
  //Đông chí thường nằm vào khoảng 19/12-22/12, như vậy trước hết ta tìm ngày Sóc trước ngày 31/12.
  //Nếu tháng bắt đầu vào ngày đó không chứa Đông chí thì ta phải lùi lại 1 tháng nữa.
  static int getLunarMonth11(int yy, int timeZone) {
    var k, off, nm, sunLong;
    off = jdFromDate(31, 12, yy) - 2415021;
    k = toInt(off / 29.530588853);
    nm = getNewMoonDay(k, timeZone);
    sunLong = getSunLongitude(nm, timeZone); // sun longitude at local midnight
    if (sunLong >= 9) {
      nm = getNewMoonDay(k - 1, timeZone);
    }
    return nm;
  }

  //Xác định tháng nhuận
  //Nếu giữa hai tháng 11 âm lịch (tức tháng có chứa Đông chí) có 13 tháng âm lịch thì năm âm lịch đó có tháng nhuận.
  static int getLeapMonthOffset(int a11, int timeZone) {
    var k, last, arc, i;
    k = toInt((a11 - 2415021.076998695) / 29.530588853 + 0.5);
    last = 0;
    i = 1; // We start with the month following lunar month 11
    arc = getSunLongitude(getNewMoonDay(k + i, timeZone), timeZone);
    do {
      last = arc;
      i++;
      arc = getSunLongitude(getNewMoonDay(k + i, timeZone), timeZone);
    } while (arc != last && i < 14);
    return i - 1;
  }

  //Convert solar day to lunar day
  static DateTime solarToLunar(int solarYear, int solarMonth, int solarDay) {
    //Vietnam timezone
    var utcValue = 7;
    var k, dayNumber, monthStart, a11, b11, lunarDay, lunarMonth, lunarYear;
    // lunarLeap;
    dayNumber = jdFromDate(solarDay, solarMonth, solarYear);
    k = toInt((dayNumber - 2415021.076998695) / 29.530588853);
    monthStart = getNewMoonDay(k + 1, utcValue);
    if (monthStart > dayNumber) {
      monthStart = getNewMoonDay(k, utcValue);
    }
    a11 = getLunarMonth11(solarYear, utcValue);
    b11 = a11;
    if (a11 >= monthStart) {
      lunarYear = solarYear;
      a11 = getLunarMonth11(solarYear - 1, utcValue);
    } else {
      lunarYear = solarYear + 1;
      b11 = getLunarMonth11(solarYear + 1, utcValue);
    }
    lunarDay = dayNumber - monthStart + 1;
    var diff = toInt((monthStart - a11) / 29);
    // lunarLeap = 0;
    lunarMonth = diff + 11;
    if (b11 - a11 > 365) {
      var leapMonthDiff = getLeapMonthOffset(a11, utcValue);
      if (diff >= leapMonthDiff) {
        lunarMonth = diff + 10;
        // if (diff == leapMonthDiff) {
        //   lunarLeap = 1;
        // }
      }
    }
    if (lunarMonth > 12) {
      lunarMonth = lunarMonth - 12;
    }
    if (lunarMonth >= 11 && diff < 4) {
      lunarYear -= 1;
    }
    DateTime result = new DateTime(lunarYear, lunarMonth, lunarDay);
    return result;
  }

  static int getLunarLeap(int yy) {
    int lunarLeap = 0;
    List<int> yyMod19 = [3, 6, 9, 11, 14, 17];
    if (yyMod19.contains(yy % 19)) {
      lunarLeap = 1;
    }
    return lunarLeap;
  }

  //Convert lunar day to solar day
  static DateTime lunarToSolar(int lunarYear, int lunarMonth, int lunarDay,
      {lunarLeap: 0}) {
    //Vietnam timezone
    var utcValue = 7;
    var k, a11, b11, off, leapOff, leapMonth, monthStart;
    if (lunarMonth < 11) {
      a11 = getLunarMonth11(lunarYear - 1, utcValue);
      b11 = getLunarMonth11(lunarYear, utcValue);
    } else {
      a11 = getLunarMonth11(lunarYear, utcValue);
      b11 = getLunarMonth11(lunarYear + 1, utcValue);
    }
    off = lunarMonth - 11;
    if (off < 0) {
      off += 12;
    }
    if (b11 - a11 > 365) {
      leapOff = getLeapMonthOffset(a11, utcValue);
      leapMonth = leapOff - 2;
      if (leapMonth < 0) {
        leapMonth += 12;
      }
      if (lunarLeap != 0 && lunarMonth != leapMonth) {
        // DateTime result = new DateTime(0, 0, 0);
      } else if (lunarLeap != 0 || off >= leapOff) {
        off += 1;
      }
    }
    k = toInt(0.5 + (a11 - 2415021.076998695) / 29.530588853);
    monthStart = getNewMoonDay(k + off, utcValue);
    return jdToDate(monthStart + lunarDay - 1);
  }
}

class TinhCanChi {
  static List<String> _can = [
    'Canh',
    'Tân',
    'Nhâm',
    'Quý',
    'Giáp',
    'Ất',
    'Bính',
    'Đinh',
    'Mậu',
    'Kỷ'
  ];
  static List<String> _chi = [
    'Thân',
    'Dậu',
    'Tuất',
    'Hợi',
    'Tý',
    'Sửu',
    'Dần',
    'Mão',
    'Thìn',
    'Tỵ',
    'Ngọ',
    'Mùi'
  ];

  static bool laNamNhuan(int year) {
    if (year % 4 == 0) {
      if (year % 100 == 0 && (year / 100 % 4 != 0)) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  static String tinhNgayCanChi(DateTime date) {
    // input là ngày dương
    //baseDate là ngày âm, 03/01/2000 là ngày "Canh Thân", giá trị trong mảnh là: can[0], chi[0]
    DateTime baseDate = new DateTime(2000, 1, 3);
    String can = "Canh", chi = "Thân";
    final soNgay = baseDate.difference(date).inDays;
    if (soNgay < 0) {
      can = _can[-soNgay % 10];
      chi = _chi[-soNgay % 12];
    } else if (soNgay > 0) {
      can = _can[10 - soNgay % 10];
      chi = _chi[12 - soNgay % 12];
    }
    return '$can $chi';
  }

  static String tinhThangCanChi(DateTime date) {
    // input phải là ngày dương
    // baseDate là ngày âm, 07/2003 là tháng Canh Thân, giá trị trong mảng là: can[0], chi[0]
    DateTime lunarDate =
        CalendarConverter.solarToLunar(date.year, date.month, date.day);
    // chuyển input sang ngày âm.
    DateTime baseDate = new DateTime(2003, 7, 1);
    String can = "Canh", chi = "Thân";
    int soThang = (baseDate.year - lunarDate.year) * 12 +
        (baseDate.month - lunarDate.month);
    if (soThang < 0) {
      can = _can[-soThang % 10];
      chi = _chi[-soThang % 12];
    } else if (soThang > 0) {
      can = _can[10 - soThang % 10];
      chi = _chi[12 - soThang % 12];
    }
    return '$can $chi';
  }

  static String tinhNamCanChi(DateTime date) {
    DateTime lunarDate =
        CalendarConverter.solarToLunar(date.year, date.month, date.day);
    String yearCan = _can[lunarDate.year % 10];
    String yearChi = _chi[lunarDate.year % 12];
    return '$yearCan $yearChi';
  }

  static String tinhThu(int weekday) {
    List thu = [
      'NULL',
      'Thứ 2',
      'Thứ 3',
      'Thứ 4',
      'Thứ 5',
      'Thứ 6',
      'Thứ 7',
      'Chủ nhật'
    ];
    return thu[weekday];
  }
}

// main(List<String> args) {
//   DateTime now = new DateTime.now();
//   print(TinhCanChi.tinhThangCanChi(DateTime(2020, 1, 5)));
//   print(TinhCanChi.tinhNamCanChi(DateTime(2020, 1, 5)));
//   DateTime lunarVi = CalendarConverter.solarToLunar(2020, 5, 8);
//   DateTime lunarJa = CalendarConverter.lunarToSolar(2020, 4, 17);
//   print(lunarVi);
//   print(lunarJa);
// }
