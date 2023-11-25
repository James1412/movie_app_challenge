import 'dart:convert';

class MovieModel {
  final String? imgPath;
  final String? posterPath;
  final List<dynamic>? genreIds;
  final int? id;
  final String? title;
  final String? description;
  final String? releaseDate;

  MovieModel.fromJson({required Map<String, dynamic> json})
      : imgPath = "https://image.tmdb.org/t/p/w500${json['backdrop_path']}",
        posterPath = "https://image.tmdb.org/t/p/w500${json['poster_path']}",
        genreIds = json["genre_ids"],
        id = json["id"],
        title = utf8.decode(json["original_title"].codeUnits),
        description = json['overview'],
        releaseDate = json['release_date'];
}
