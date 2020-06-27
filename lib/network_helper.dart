import 'dart:core';

import 'package:http/http.dart' as http_dart;

class NetworkHelper {
  final String _baseUrl = 'https://api.themoviedb.org/3/movie/';
  final String _imageBaseUrl = 'https://image.tmdb.org/t/p/';
  final String _apiKey = 'e061fd93dd9971a5fc7835f00fb235c5';

  Future<http_dart.Response> getPopularMovies(int page) {
    var moviesUrl =
        _baseUrl + 'popular?api_key=$_apiKey&language=en-US&page=$page';
    print(moviesUrl);
    var response = http_dart.Client().get(moviesUrl);
    return response;
  }

  Future<http_dart.Response> getMovieDetails(int movieId) {
    print('movie_id:$movieId');
    var _movieDetailsUrl =
        _baseUrl + '${movieId.toString()}?api_key=$_apiKey&language=en-US';
    print(_movieDetailsUrl);
    return http_dart.Client().get(_movieDetailsUrl);
  }
}
