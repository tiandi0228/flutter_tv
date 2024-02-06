class LabelItem {
  // 影片名称
  final String movieName;

  // 影片地址
  final String movieUrl;

  LabelItem(this.movieName, this.movieUrl);

  @override
  String toString() {
    return 'LabelItem{movieName: $movieName, movieUrl: $movieUrl}';
  }
}
