import 'package:flutter/cupertino.dart';

class TermsAndConditions {
  final String title, description;
  bool expanded;

  TermsAndConditions({
    this.expanded: false,
    @required this.title,
    @required this.description,
  });
  factory TermsAndConditions.fromJson(Map json) {
    return TermsAndConditions(
      title: json['title'],
      description: json['description'],
    );
  }
}
