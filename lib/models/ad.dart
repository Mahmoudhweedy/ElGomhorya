class Ad {
  final String image;

  Ad({this.image});
  factory Ad.fromJson(Map json) => Ad(image: json['image']);
}
