class Pixabay {
  final String previewURL;
  final String tags;

  Pixabay({
    required this.previewURL,
    required this.tags,
  });

  factory Pixabay.fromJson(Map<String, dynamic> json) {
    return Pixabay(
      previewURL: json['previewURL'],
      tags: json['tags'],
    );
  }

  static List<Pixabay> listToAlbums(List jsonList) {
    return jsonList.map((e) => Pixabay.fromJson(e)).toList();
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Pixabay{previewURL: $previewURL, tags: $tags}';
  }
}
