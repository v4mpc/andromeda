import 'package:intl/intl.dart';


class Util{
  static String formatDate(String stringDate) {
    final inputFormat = DateFormat('yyyy-MM-dd');
    final inputDate = inputFormat.parse(stringDate);
    final outputFormat = DateFormat('d MMM yy');
    return outputFormat.format(inputDate);
  }
}