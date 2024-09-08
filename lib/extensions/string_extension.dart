import 'package:intl/intl.dart';

extension StringExtension on String {
  String get dateFormat => DateFormat('dd/MM/yyyy').format(
        DateTime.parse(this),
      );

  String get timeFormat => DateFormat('HH:mm:ss').format(
        DateTime.parse(this),
      );
}
