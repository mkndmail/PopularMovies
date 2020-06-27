import 'dart:convert' as dart_convert;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_movie_app/models/movie_details_response.dart';
import 'package:my_movie_app/network_helper.dart';
import 'package:my_movie_app/resources/app_colors.dart';

class MovieDetails extends StatefulWidget {
  @override
  _MovieDetailsState createState() => _MovieDetailsState();
  final int movieID;
  final String movieTitle;
  MovieDetails({this.movieID, this.movieTitle});
}

class _MovieDetailsState extends State<MovieDetails> {
  NetworkHelper _networkHelper;
  @override
  void initState() {
    super.initState();
    _networkHelper = NetworkHelper();
    getMovieInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movieTitle),
          backgroundColor: kBlueLight
      ),
      body: FutureBuilder<MovieDetailsResponse>(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          } else {
            return snapshot.hasData
                ? ShowMovieDetails(
                    movieDetailsResponse: snapshot.data,
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }
        },
        future: getMovieInfo(),
      ),
    );
  }

  Future<MovieDetailsResponse> getMovieInfo() async {
    print(widget.movieID);
    final movieResponse = await _networkHelper.getMovieDetails(widget.movieID);
    var response =
        dart_convert.jsonDecode(movieResponse.body) as Map<String, dynamic>;
    return MovieDetailsResponse.fromJson(response);
  }
}

class ShowMovieDetails extends StatelessWidget {
  final MovieDetailsResponse movieDetailsResponse;

  ShowMovieDetails({this.movieDetailsResponse});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Image.network(
                'https://image.tmdb.org/t/p/original${movieDetailsResponse.posterPath}',
                fit: BoxFit.fill,

              ),
            ),
            SizedBox(height: 8),
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  Text(
                    movieDetailsResponse.originalTitle,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Revenue'),
                      Text(movieDetailsResponse.revenue.toString()),

                      Text('Release'),
                      Text(movieDetailsResponse.releaseDate),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(movieDetailsResponse.overView),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
