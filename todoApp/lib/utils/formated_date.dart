import 'package:intl/intl.dart';

class DateTimeUtils {
  bool validateDateTime(String input) {
    try {
      if (input.length > 10) {
        return false;
      }

      var date =
          "${input.substring(6, 10)}-${input.substring(3, 5)}-${input.substring(0, 2)}";
      DateTime.parse(date);
    } catch (e) {
      return false;
    }
    return true;
  }

  static String convertDate(String input) {
    var date =
        "${input.substring(6, 10)}-${input.substring(3, 5)}-${input.substring(0, 2)}";
    return DateFormat("dd/MM/yyyy").format(DateTime.parse(date));
  }

  static String convertDateToJson(DateTime input) {
    return input.toIso8601String();
  }

  static String convertStringToDateJson(String input) {
    var date =
        "${input.substring(6, 10)}-${input.substring(3, 5)}-${input.substring(0, 2)}";
    return DateTime.parse(date).toIso8601String();
  }
}
