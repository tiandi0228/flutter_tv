class SearchMovie {
  // 导演
  String movieDirector;

  // 主演
  String movieStarring;

  // 影片名称
  String movieName;

  // 影片缩略图
  String moviePic;

  // 影片当前更新状态
  String movieText;

  // 影片地址
  String movieUrl;

  // 影片上映年份
  String movieYear;

  // 影片分类
  String movieClass;

  // 影片来源地
  String movieSource;

  SearchMovie(
      this.moviePic,
      this.movieName,
      this.movieClass,
      this.movieYear,
      this.movieSource,
      this.movieDirector,
      this.movieStarring,
      this.movieText,
      this.movieUrl);

  @override
  String toString() {
    return 'SearchMovie{moviePic: $moviePic, movieName: $movieName, movieClass: $movieClass, movieYear: $movieYear,  movieSource: $movieSource, movieDirector: $movieDirector, movieStarring: $movieStarring, movieText: $movieText, movieUrl: $movieUrl}';
  }
}
