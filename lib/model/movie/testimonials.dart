class TestimonialsItem {
  // 影片名称
  final String movieName;

  // 影片缩略图
  final String moviePic;

  // 影片当前更新状态
  final String movieText;

  // 影片地址
  final String movieUrl;

  // 影片上映年份
  final String movieYear;

  // 影片分类
  final String movieClass;

  // 影片来源地
  final String movieSource;

  TestimonialsItem(this.movieName, this.moviePic, this.movieText, this.movieUrl,
      this.movieYear, this.movieClass, this.movieSource);

  @override
  String toString() {
    return 'TestimonialsItem{movieName: $movieName, moviePic: $moviePic, movieText: $movieText, movieUrl: $movieUrl, movieYear: $movieYear, movieClass: $movieClass, movieSource: $movieSource}';
  }
}
