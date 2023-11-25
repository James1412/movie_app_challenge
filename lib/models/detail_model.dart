import 'dart:convert';

class MovieDetailModel {
  final String? title;
  final String? imgPath;
  final genres;
  final String? homePage;
  final String? description;
  final String? posterPath;
  final int? id;
  final int? runTime;

  MovieDetailModel.fromJson({required Map<String, dynamic> json})
      : title = utf8.decode(json['original_title'].codeUnits),
        description = json['overview'],
        imgPath = "https://image.tmdb.org/t/p/w500/${json['backdrop_path']}",
        posterPath = "https://image.tmdb.org/t/p/w500/${json['poster_path']}",
        genres = json['genres'],
        homePage = json['homepage'],
        id = json['id'],
        runTime = json['runtime'];
}
