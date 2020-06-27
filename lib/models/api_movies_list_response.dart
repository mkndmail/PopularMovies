import 'package:json_annotation/json_annotation.dart';
import 'package:my_movie_app/models/results.dart';
part 'api_movies_list_response.g.dart';
@JsonSerializable()
class MovieResponse{
  final int page;
  @JsonKey(name: 'total_results')
  final int totalResults;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  final List<Result> results;
  MovieResponse({this.page,this.totalResults,this.totalPages,this.results});
  factory MovieResponse.fromJson(Map<String,dynamic> json)=>_$MovieResponseFromJson(json);

  Map<String,dynamic> toJson()=>_$MovieResponseToJson(this);
}