// To parse this JSON data, do
//
//     final series = seriesFromJson(jsonString);

import 'dart:convert';

List<Series> seriesFromJson(String str) =>
    List<Series>.from(json.decode(str).map((x) => Series.fromJson(x)));

String seriesToJson(List<Series> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Series {
  Series({
    required this.id,
    required this.title,
    required this.year,
    required this.director,
    required this.duration,
    required this.rate,
    required this.type,
    required this.description,
    required this.thumbUrl,
    required this.bannerUrl,
  });

  int id;
  String title;
  String year;
  String director;
  int duration;
  int rate;
  String type;
  String description;
  String thumbUrl;
  String bannerUrl;

  factory Series.fromJson(Map<String, dynamic> json) => Series(
        id: json["id"],
        title: json["title"],
        year: json["year"],
        director: json["director"],
        duration: json["duration"],
        rate: json["rate"],
        type: json["type"],
        description: json["description"],
        thumbUrl: json["thumb_url"],
        bannerUrl: json["banner_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "year": year,
        "director": director,
        "duration": duration,
        "rate": rate,
        "type": type,
        "description": description,
        "thumb_url": thumbUrl,
        "banner_url": bannerUrl,
      };
}
