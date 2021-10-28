import 'package:intl/intl.dart'; //날짜

class CommUtils {
  /*
   * Null 체크
   * arg String
   * return ""
   */
  String stringNullCheck(String s) {
    if (s != null && s != "") {
      return s;
    } else {
      return "";
    }
  }

  bool boolNullCheck(bool b) {
    if (b != null) {
      return false;
    } else {
      return true;
    }
  }

  int numNullCheck(int n) {
    if (n != null && n != 0) {
      return n;
    } else {
      return 0;
    }
  }


  /*
  * 날짜 변환 -> formatYmd
  * arg String
  *     'yyyy-MM-dd
  * return YYYY-MM-DD
  */
  String convFormatYmdKo(String arg, [String formatYmd = 'yyyy넌 MM월 dd일']) {
    if (stringNullCheck(arg) != "") {
      return DateFormat(formatYmd).format(DateTime.parse(arg));
    } else {
      return stringNullCheck(arg);
    }
  }

  /*
  * 날짜 변환 -> formatYmd
  * arg String
  *     'yyyy-MM-dd
  * return YYYY-MM-DD
  */
  String convFormatYmd(String arg, [String formatYmd = 'yyyy-MM-dd']) {
    if (stringNullCheck(arg) != "") {
      return DateFormat(formatYmd).format(DateTime.parse(arg));
    } else {
      return stringNullCheck(arg);
    }
  }

  /*
   * 날짜 변환 -> formatYmd
   * arg    DateTime
   *        'yyyy-MM-dd
   * return YYYY-MM-DD
   */
  String convFormatDatatime(DateTime arg, [String formatYmd = 'yyyy-MM-dd']) {
    return DateFormat(formatYmd).format(arg);
  }

  /*
   * 날짜 변환 -> YYYY-MM-DD
   * arg    String
   * return YYYY-MM-DD
   */
  String nowYmd() {
    print(DateTime.now());
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  /*
   * 날짜 변환 -> YYYYMMDD
   * arg    String
   * return YYYYMMDD
   */
  String nowYmdNoDash() {
    print(DateTime.now());
    return DateFormat('yyyyMMdd').format(DateTime.now());
  }

  /*
   * 입력받은 달의 말일
   * arg    String
   * return YYYY-MM-DD
   */
  String firstDaysInMonthYmd(String arg) {
    DateTime date = DateTime.parse(arg);
    return date.year.toString() + '-' + date.month.toString() + '-01';
  }

  /*
   * 입력받은 달의 말일
   * arg    String
   * return YYYY-MM-DD
   */
  String lastDaysInMonthYmd(String arg) {
    DateTime date = DateTime.parse(arg);
    return date.year.toString() + '-' + date.month.toString() + '-' + lastDaysInMonth(date).toString();
  }

  /*
   * 달의 1일
   * arg    DateTime
   * return DateTime
   */
  DateTime firstDaysInMonthDataTime(DateTime date) {
    return new DateTime(date.year, date.month, 1);
  }

  /*
   * 달의 말일
   * arg    DateTime
   * return DateTime
   */
  DateTime lastDaysInMonthDataTime(DateTime date) {
    return new DateTime(date.year, date.month, lastDaysInMonth(date));
  }

  /*
   * 이번달 1일
   * arg    DateTime
   * return YYYY-MM-DD
   */
  DateTime nowFirstDaysInMonthDataTime() {
    DateTime date = DateTime.now();
    return new DateTime(date.year, date.month, 1);
  }

  /*
   * 이번달 말일
   * arg    DateTime
   * return YYYY-MM-DD
   */
  DateTime nowLastDaysInMonthDataTime() {
    DateTime date = DateTime.now();
    return new DateTime(date.year, date.month, lastDaysInMonth(date));
  }

  /*
   * 해당 월을 마지막 일자 계산
   * arg    DateTime
   * return Int
   */
  int lastDaysInMonth(DateTime date) {
    var firstDayThisMonth = new DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = new DateTime(firstDayThisMonth.year, firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  /*
   * 숫자 3자리마다 , 표시 포맷 변환
   * arg    String
   * return String
   */
  String numFormat(String text) {
    RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function mathFunc = (Match match) => '${match[1]},';
    String result = text.replaceAllMapped(reg, mathFunc);
    return result;
  }

  /*
   * 전화번호 변환 -> formatTelNumber
   * arg    String
   * return String ex) 000-0000-0000
   */
  String telNumberFormat(String arg) {
    Function mathFunc = (Match match) => '${match[1]}-${match[2]}-${match[3]}';
    String result = arg.replaceAll(RegExp(r'[^0-9]/g'), "").replaceAllMapped(RegExp(r'(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})'), mathFunc);
    return result;
  }

  /*
   * 날짜 변환 -> formatYmd
   * arg String ex)20210413 8자리, 구분자 String ex) '-', '.'
   * return YYYY구분자MM구분자DD ex)2021-04-13 or 2021.04.13 etc
   */
  String ymdFormat(String arg, String separator) {
    return DateFormat('yyyy${separator}MM${separator}dd').format(DateTime.parse(arg));
  }

  /*
   * 세자리 단위 숫자를 문자로 표현
   * 1000 -> 1K...
   */
  String longNumberFormat(String currentBalance) {
    try {
      double value = double.parse(currentBalance);
      if (value < 1000) {
        return value.toStringAsFixed(0).toString();
      } else if (value >= 1000 && value < 1000000) {
        return (value / 1000).toStringAsFixed(1) + "K";
      } else {
        return (value / 1000000).toStringAsFixed(1) + "M";
      }
    } catch (e) {
      print(e);
      return e;
    }
  }

  /*
   * 만 나이계산
   */
  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }
}
