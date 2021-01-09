import 'dart:convert';

import 'package:nasa_picture_of_day_project/modules/search_pictures/domain/entities/picture_of_the_day.dart';

class PictureOfTheDayModel extends PictureOfTheDay {
  final String title;
  final String date;
  final String explanation;
  final String url;

  PictureOfTheDayModel({
    this.title,
    this.date,
    this.explanation,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'explanation': explanation,
      'url': url,
    };
  }

  factory PictureOfTheDayModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PictureOfTheDayModel(
      title: map['title'],
      date: map['date'],
      explanation: map['explanation'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PictureOfTheDayModel.fromJson(String source) =>
      PictureOfTheDayModel.fromMap(json.decode(source));
}
