import 'package:flutter/foundation.dart';

class Movie{
  final String imdbId;
  final String poster;
  final String title;
  final String year;
  final String type;

  Movie({
    required this.imdbId,
    required this.poster,
    required this.title,
    required this.year,
    required this.type,
  });
  factory Movie.fromJson(Map<String,dynamic> json){
    return Movie(imdbId: json["imdbID"],
        poster: json["Poster"],
        title: json["Title"],
        year: json["Year"],
        type: json["Type"]);
  }

  Map<String,dynamic> toJson()=>{
    "imdbId" : imdbId,
    "Poster" : poster,
    "Title"  : title,
    "Year"   : year,
    "Type"   : type
  };
}
