import 'package:mybookstore/shared/utils/string_utils.dart';

extension DateTimeExtension on DateTime {
  String get formattedDate =>
      '${day.toString().withZero}/${month.toString().withZero}/${year.toString().withZero}';

  String get formattedTime =>
      '${hour.toString().withZero}:${minute.toString().withZero}';

  String get formattedDateTime => '$formattedDate $formattedTime';
}
