class Social {
  final String fb, twitter, youTube, website;

  Social({
    this.fb,
    this.twitter,
    this.youTube,
    this.website,
  });
  factory Social.fromJson(Map json) => Social(
        fb: json['facebook_link'],
        twitter: json['twitter_link'],
        website: json['website_link'],
        youTube: json['youtube_link'],
      );
}
