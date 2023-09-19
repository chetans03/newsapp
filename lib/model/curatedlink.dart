class Curatedlinks {
  String title;
  String link;
  Curatedlinks(this.title, this.link);
}

List<Curatedlinks> apilinks = [
  Curatedlinks("CNN",
      "https://newsapi.org/v2/top-headlines?sources=cnn&apiKey=b2341dbf30e642e696d122a0bee05c26"),
  Curatedlinks("BBC-News",
      "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=b2341dbf30e642e696d122a0bee05c26"),
  Curatedlinks("NBS-News",
      "https://newsapi.org/v2/top-headlines?sources=nbs-news&apiKey=b2341dbf30e642e696d122a0bee05c26"),
  Curatedlinks("Fox-News",
      "https://newsapi.org/v2/top-headlines?sources=fox-news&apiKey=b2341dbf30e642e696d122a0bee05c26"),
  Curatedlinks("Reuters",
      "https://newsapi.org/v2/top-headlines?sources=reuters&apiKey=b2341dbf30e642e696d122a0bee05c26"),
  Curatedlinks("NBC-News",
      "https://newsapi.org/v2/top-headlines?sources=nbs-news&apiKey=b2341dbf30e642e696d122a0bee05c26")
];
