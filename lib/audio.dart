class Audio {
  Audio(this.title, this.path);
  final String title;
  final String path;

  static Audio fromMap(Map < String, Object ? > map) {
    return Audio(map['title'] !as String, map['path'] !as String);
  }
}