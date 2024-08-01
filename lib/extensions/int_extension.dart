extension IntExtension on int {
  String get formatTime {
    int minutes = this ~/ 60;
    int remainingSeconds = this % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
