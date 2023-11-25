// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:movie_app_2/components/movie_list.dart';
import 'package:movie_app_2/components/popular_text.dart';
import 'package:movie_app_2/components/smaller_text.dart';
import 'package:movie_app_2/models/movie_model.dart';
import 'package:movie_app_2/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Call the ApiService when this class starts
  Future<List<MovieModel>> movies = MovieService.getPopularMovies();
  Future<List<MovieModel>> cinemaMovies = MovieService.getInCinema();
  Future<List<MovieModel>> comingMovies = MovieService.getComingSoon();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Movie App",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 5,
        shadowColor: Colors.deepPurple,
        backgroundColor: Colors.deepPurple.shade500,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PopularText(popular: "Popular Movies"),
                MovieList(
                  movies: movies,
                  isLarge: true,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SmallerText(text: "Now in Cinema"),
                MovieList(
                  movies: cinemaMovies,
                  isLarge: false,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SmallerText(text: "Coming soon"),
                MovieList(
                  movies: comingMovies,
                  isLarge: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
