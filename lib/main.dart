import 'dart:convert' as dart_convert;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_movie_app/models/api_movies_list_response.dart';
import 'package:my_movie_app/models/results.dart';
import 'package:my_movie_app/movie_details_page.dart';
import 'package:my_movie_app/network_helper.dart';
import 'package:my_movie_app/resources/app_colors.dart';
import 'package:async/async.dart' as dart_async;

void main() {
  runApp(MainPageWidget());
}

NetworkHelper _networkHelper;
int page = 1;
const kApiKey = 'e061fd93dd9971a5fc7835f00fb235c5';

class MainPageWidget extends StatefulWidget {
  @override
  _MainPageWidgetState createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {

  @override
  void initState() {
    super.initState();
    _networkHelper = NetworkHelper();
    getMovieNames();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Popular Movies'),
          backgroundColor: kBlueLight,
        ),
        body: FutureBuilder<MovieResponse>(
          future: getMovieNames(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            } else {
              return snapshot.hasData
                  ? MovieAlbumGrid(moviesList: snapshot.data.results)
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }
          },
        ),
      ),
    );
  }
}

Future<MovieResponse> getMovieNames() async {
  print(
      'request_url= https://api.themoviedb.org/3/movie/popular?api_key=$kApiKey&language=en-US&page=$page');
  final response = await _networkHelper.getPopularMovies(page);
  return compute(parseMovieResponse, response.body);
}

MovieResponse parseMovieResponse(String body) {
  final parsedResponse = dart_convert.jsonDecode(body);
  return MovieResponse.fromJson(parsedResponse as Map<String, dynamic>);
}

class MovieAlbumGrid extends StatefulWidget {
  final List<Result> moviesList;

  MovieAlbumGrid({this.moviesList});

  @override
  _MovieAlbumGridState createState() => _MovieAlbumGridState();
}

class _MovieAlbumGridState extends State<MovieAlbumGrid> {
  List<Result> _movies;
  final ScrollController scrollController = ScrollController();
  MovieLoadMoreStatus loadMoreStatus = MovieLoadMoreStatus.STABLE;
  dart_async.CancelableOperation movieOperation;

  @override
  void initState() {
    super.initState();
    _movies = widget.moviesList;
  }

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {
        if (loadMoreStatus != null &&
            loadMoreStatus == MovieLoadMoreStatus.STABLE) {
          loadMoreStatus = MovieLoadMoreStatus.LOADING;
          setState(() {
            page++;
          });
          movieOperation =
              dart_async.CancelableOperation.fromFuture(getMovieNames())
                  .then((movie) {
            loadMoreStatus = MovieLoadMoreStatus.STABLE;
            setState(() => _movies.addAll(movie.results));
          });
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: onNotification,
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        controller: scrollController,
        itemBuilder: (context, index) {
          final movieData = _movies[index];
          return GestureDetector(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
                // BorderRadius.all
              ), // RoundedRectangleBorder
              color: Colors.white,
              elevation: 5.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/original${movieData.posterPath}',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 5.0, right: 5.0),
                        child: Text('Rating : ${movieData.voteAverage}'),
                      ), // Padding
                    ),
                  )
                ],
              ),
              // Align
              //  <Widget>[]
              // Stack
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MovieDetails(
                            movieTitle: movieData.originalTitle,
                        movieID: movieData.id,
                          )));
            },
          );
        },
        itemCount: _movies.length,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}

enum MovieLoadMoreStatus { LOADING, STABLE }