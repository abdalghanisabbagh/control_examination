/// Extension methods on [int].
extension IntExtension on int {
  /// Formats a time given in seconds as a string in the format "mm:ss".
  ///
  /// Example: 90 => "01:30"
  String get formatTime {
    // Calculate the minutes and remaining seconds from the total seconds.
    int minutes = this ~/ 60;
    int remainingSeconds = this % 60;

    // Format the time as a string in the format "mm:ss".
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
