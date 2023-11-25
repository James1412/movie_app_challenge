import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_app_2/models/detail_model.dart';
import 'package:movie_app_2/models/movie_model.dart';
import 'package:movie_app_2/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final MovieModel movie;
  const DetailScreen({super.key, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movieDetail;
  bool imgExist = true;
  @override
  void initState() {
    super.initState();
    movieDetail = MovieService.getDetailMovie("${widget.movie.id}");
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movie.imgPath == null ||
        widget.movie.imgPath!.contains('null')) {
      imgExist = false;
    }
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imgExist
              ? NetworkImage(widget.movie.imgPath!)
              : const NetworkImage(
                  "https://images.wondershare.com/repairit/aticle/2021/07/resolve-images-not-showing-problem-1.jpg",
                ),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            widget.movie.title!,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          elevation: 5,
          shadowColor: Colors.deepPurple,
          backgroundColor: Colors.deepPurple.shade500,
        ),
        body: FutureBuilder(
            future: movieDetail,
            builder: (context, futureData) {
              if (futureData.hasData) {
                dynamic duration = Duration(minutes: futureData.data!.runTime!);
                duration = duration.toString().split(".")[0].split(":");
                var listOfGenres = [];
                for (var i in futureData.data!.genres!) {
                  listOfGenres.add(i["name"]);
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            height: MediaQuery.of(context).size.height * 0.35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: NetworkImage(
                                  futureData.data!.posterPath!,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05),
                          child: Text(
                            futureData.data!.title!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.075,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Text(
                                  '${duration[0]}h ${duration[1]}min | ',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  listOfGenres.join(", "),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "Storyline",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.03,
                            right: MediaQuery.of(context).size.width * 0.1,
                            bottom: MediaQuery.of(context).size.width * 0.08,
                          ),
                          child: Text(
                            utf8.decode(
                                futureData.data!.description!.codeUnits),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              if (futureData.data!.homePage != null &&
                                  futureData.data!.homePage != "") {
                                final url =
                                    Uri.parse(futureData.data!.homePage!);
                                await launchUrl(url);
                              } else {
                                var alert = const AlertDialog(
                                  title: Text("This link does not exist"),
                                );
                                showDialog(
                                    context: context,
                                    builder: (context) => alert);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 50.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8D749),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Buy ticket",
                                  style: TextStyle(
                                    color: Color(0xFF613EAE),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
