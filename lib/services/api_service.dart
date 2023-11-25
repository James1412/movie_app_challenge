import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app_2/models/detail_model.dart';
import 'package:movie_app_2/models/movie_model.dart';

class MovieService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String popular = "popular";
  static const String inCinema = "now-playing";
  static const String comingSoon = "coming-soon";

  static Future<List<MovieModel>> getPopularMovies() async {
    List<MovieModel> movieInstances = [];
    final response = await http.get(Uri.parse("$baseUrl/$popular"));
    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)['results'];
      for (var movie in movies) {
        MovieModel value = MovieModel.fromJson(json: movie);
        movieInstances.add(value);
      }
      return movieInstances;
    } else {
      throw Error();
    }
  }

  static Future<List<MovieModel>> getInCinema() async {
    List<MovieModel> movieInstances = [];
    final response = await http.get(Uri.parse("$baseUrl/$inCinema"));
    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)['results'];
      for (var movie in movies) {
        MovieModel value = MovieModel.fromJson(json: movie);
        movieInstances.add(value);
      }
      return movieInstances;
    } else {
      throw Error();
    }
  }

  static Future<List<MovieModel>> getComingSoon() async {
    List<MovieModel> movieInstances = [];
    final response = await http.get(Uri.parse("$baseUrl/$comingSoon"));
    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)['results'];
      for (var movie in movies) {
        MovieModel value = MovieModel.fromJson(json: movie);
        movieInstances.add(value);
      }
      return movieInstances;
    } else {
      throw Error();
    }
  }

  static Future<MovieDetailModel> getDetailMovie(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/movie?id=$id"));
    if (response.statusCode == 200) {
      final value = jsonDecode(response.body);
      return MovieDetailModel.fromJson(json: value);
    } else {
      throw Error();
    }
  }
}
