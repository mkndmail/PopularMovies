import 'package:json_annotation/json_annotation.dart';

part 'results.g.dart';

@JsonSerializable()
class Result {
  @JsonKey(name: 'vote_count')
  final int voteCount;
  @JsonKey(name: 'poster_path')
  final String posterPath;
  @JsonKey(name: 'backdrop_path')
  final String backdropPath;
  final int id;
  final String title;
  @JsonKey(name: 'original_language')
  final String originalLanguage;
  @JsonKey(name: 'original_title')
  final String originalTitle;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'overview')
  final String overView;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  final bool adult;

  Result(
      {this.voteCount,
      this.posterPath,
      this.backdropPath,
      this.id,
      this.title,
      this.voteAverage,
      this.overView,
      this.releaseDate,
      this.adult,
      this.originalLanguage,
      this.originalTitle});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
