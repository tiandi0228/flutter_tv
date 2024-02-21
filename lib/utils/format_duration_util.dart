class FormatDurationUtil {
  static String formatDuration(Duration duration) {
    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (duration.inHours.toString() != '0') {
      return "$hours:$minutes:$seconds";
    }
    return "$minutes:$seconds";
  }
}
