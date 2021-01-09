class PictureOfTheDay {
  final String title;
  final String date;
  final String explanation;
  final String url;

  PictureOfTheDay({
    this.title,
    this.date,
    this.explanation,
    this.url,
  });

  @override
  String toString() {
    return 'PictureOfTheDay(title: $title, date: $date, explanation: $explanation, url: $url)';
  }
}
