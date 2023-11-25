import 'package:flutter/material.dart';
import 'package:movie_app_2/components/large_movie.dart';
import 'package:movie_app_2/models/movie_model.dart';

class MovieList extends StatelessWidget {
  final Future<List<MovieModel>> movies;
  final bool isLarge;
  const MovieList({super.key, required this.movies, required this.isLarge});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Waits for the data
      // It solves the problem of awaiting for data without using StatefulWidget
      future: movies,
      builder: (context, futureData) {
        if (futureData.hasData) {
          return Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: futureData.data!.length,
              itemBuilder: (context, index) {
                var movie = futureData.data![index];
                return LargeMovie(
                  movie: movie,
                  isLarge: isLarge,
                );
              },
            ),
          );
        } else {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                const CircularProgressIndicator(),
              ],
            ),
          );
        }
      },
    );
  }
}
