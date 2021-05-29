class Review {
  final String comment;
  final int rate;
  final String fName, lName, image;

  Review({
    this.fName,
    this.lName,
    this.image,
    this.comment,
    this.rate,
  });
  factory Review.fromJson(Map json) {
    return Review(
      comment: json['comment'],
      rate: json['number'],
      fName: json["customer"][0]["f_name"],
      lName: json["customer"][0]["l_name"],
      image: json["customer"][0]['image'],
    );
  }
}

