import 'package:json_annotation/json_annotation.dart';
part 'movie_details_response.g.dart';
@JsonSerializable()
class MovieDetailsResponse {
  @JsonKey(name: 'poster_path')
  final String posterPath;
  @JsonKey(name: 'budget')
  final double budget;
  @JsonKey(name: 'adult')
  final bool isAdult;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'original_title')
  final String originalTitle;
  @JsonKey(name: 'overview')
  final String overView;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  @JsonKey(name: 'revenue')
  final double revenue;
  @JsonKey(name: 'runtime')
  final int minutes;

  MovieDetailsResponse(
      this.posterPath,
      this.budget,
      this.isAdult,
      this.id,
      this.originalTitle,
      this.overView,
      this.releaseDate,
      this.revenue,
      this.minutes);

  factory MovieDetailsResponse.fromJson(Map<String,dynamic> json)=>_$MovieDetailsResponseFromJson(json);

  Map<String,dynamic> toJson()=>_$MovieDetailsResponseToJson(this);
}
