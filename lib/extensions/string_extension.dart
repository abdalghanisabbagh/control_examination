import 'package:intl/intl.dart';

/// Extension methods on [String].
extension StringExtension on String {
  /// Formats a date string from the server as a string in the format "dd/MM/yyyy".
  ///
  /// Example: "2022-01-01T00:00:00.000Z" => "01/01/2022"
  String get dateFormat => DateFormat('dd/MM/yyyy').format(
        DateTime.parse(this),
      );

  /// Formats a time string from the server as a string in the format "HH:mm:ss".
  ///
  /// Example: "2022-01-01T00:00:00.000Z" => "00:00:00"
  String get timeFormat => DateFormat('HH:mm:ss').format(
        DateTime.parse(this),
      );
}
