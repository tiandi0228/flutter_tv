class EpisodesItem {
  // 影片地址
  final String movieUrl;

  // 影片集数
  final String movieName;

  EpisodesItem(this.movieUrl, this.movieName);

  @override
  String toString() {
    return 'EpisodesItem{movieUrl: $movieUrl, movieName: $movieName}';
  }
}
