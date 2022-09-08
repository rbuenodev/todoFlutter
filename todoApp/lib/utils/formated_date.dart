import 'package:intl/intl.dart';

class DateTimeUtils {
  bool validateDateTime(String input) {
    try {
      var date =
          "${input.substring(6, 10)}-${input.substring(3, 5)}-${input.substring(0, 2)}";
      DateFormat("MM/dd/yyyy").format(DateTime.parse(date));
    } catch (e) {
      return false;
    }
    return true;
  }

  static String convertDate(String input) {
    var date =
        "${input.substring(6, 10)}-${input.substring(3, 5)}-${input.substring(0, 2)}";
    return DateFormat("MM/dd/yyyy").format(DateTime.parse(date));
  }

  static String convertDateToJson(DateTime input) {
    return input.toIso8601String();
  }

  static String convertStringToDateJson(String input) {
    var date =
        "${input.substring(6, 10)}-${input.substring(3, 5)}-${input.substring(0, 2)}";
    var formatedDate = DateFormat("MM/dd/yyyy").format(DateTime.parse(date));
    return DateTime.parse(formatedDate).toIso8601String();
  }
}
