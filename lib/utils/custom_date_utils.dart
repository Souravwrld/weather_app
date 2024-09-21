// lib/utils/date_utils.dart

import 'package:intl/intl.dart';
// Reference: https://stackoverflow.com/questions/16126579/how-do-i-format-a-date-with-dart

class CustomDateUtils {
  // ---------- Format Date as "August 15" ----------
  static String formatDate(DateTime date) {
    return DateFormat('MMMM d').format(date);
  }

  // ---------- Format Day as "Thursday" ----------
  static String formatDay(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  // ---------- Format Full Date as "August 15 | Thursday" ----------
  static String formatFullDate(DateTime date) {
    final String formattedDate = formatDate(date);
    final String formattedDay = formatDay(date);
    return '$formattedDate | $formattedDay'; // August 15 | Thursday
  }

  // ---------- Format Time as "5:53" ----------
  static String formatTime(DateTime date) {
    return DateFormat('h:mm').format(date); // 5:53 format without AM/PM
  }

  // ---------- Format Time Period as "AM/PM" ----------
  static String formatPeriod(DateTime date) {
    return DateFormat('a').format(date).toLowerCase(); // am/pm format
  }
}
