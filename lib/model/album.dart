class Album {
  final int userId;
  final int id;
  final String title;

  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  // 네트워크에서 받은 데이터를 위의 클래스로 받기 위해 사용
  // 제이슨 형태로 받은 데이터를   앨법 객체를 만드는 생성자 (Album.fromJson(...)) factory named constructor..
  // 제이슨 들어 올때 map으로 받음.. 키는 string, 값은 dynamic
  // 상용구... 처럼 사용..
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

  //
  static List<Album> listToAlbums(List jsonList) {
    return jsonList.map((e) => Album.fromJson(e)).toList();
  }

  // 별도로 추가함
  @override
  String toString() {
    return 'Album{userId: $userId, id: $id, title: $title}';
  }

}