import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime? {
  String toDateString({String type = "HH:mm"}) {
    return this != null ? DateFormat(type).format(this!) : "";
  }
}
