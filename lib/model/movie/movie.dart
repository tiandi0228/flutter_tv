class Movie {
  // 影片名称
  String movieName;

  // 影片当前集数
  String moviePage;

  // 影片上映年份
  String movieYear;

  // 影片分类
  String movieClass;

  // 影片来源地
  String movieSource;

  Movie(this.movieName, this.moviePage, this.movieYear, this.movieClass,
      this.movieSource);

  @override
  String toString() {
    return 'Movie{movieName: $movieName, moviePage: $moviePage, movieYear: $movieYear, movieClass: $movieClass, movieSource: $movieSource}';
  }
}
