class Audio {
  Audio(this.title, this.path);
  final String title;
  final String path;

  static Audio fromJson(Map < String, Object ? > json) {
    return Audio(json['title'] !as String, json['path'] !as String);
  }
}