// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:movie_app_2/models/movie_model.dart';
import 'package:movie_app_2/screens/detailed_screen.dart';

class LargeMovie extends StatelessWidget {
  final MovieModel movie;
  final bool isLarge;
  LargeMovie({super.key, required this.movie, required this.isLarge});
  bool imgExist = true;
  @override
  Widget build(BuildContext context) {
    if (movie.imgPath == null || movie.imgPath!.contains("null")) {
      imgExist = false;
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              movie: movie,
            ),
            fullscreenDialog: true,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.height * 0.01,
          bottom: MediaQuery.of(context).size.height * 0.03,
        ),
        child: Column(
          children: [
            Container(
                width: isLarge
                    ? MediaQuery.of(context).size.width * 0.80
                    : MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.23,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: MediaQuery.of(context).size.height * 0.01,
                      color: Colors.grey,
                      offset:
                          Offset(0, MediaQuery.of(context).size.height * 0.01),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: imgExist
                        ? NetworkImage(
                            movie.imgPath!,
                          )
                        : const NetworkImage(
                            "https://images.wondershare.com/repairit/aticle/2021/07/resolve-images-not-showing-problem-1.jpg",
                          ),
                  ),
                )),
            if (!isLarge)
              const SizedBox(
                height: 10,
              ),
            if (!isLarge)
              SizedBox(
                width: 170,
                child: Center(
                  child: Text(
                    movie.title!,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
