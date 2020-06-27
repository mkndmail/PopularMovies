// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsResponse _$MovieDetailsResponseFromJson(Map<String, dynamic> json) {
  return MovieDetailsResponse(
    json['poster_path'] as String,
    (json['budget'] as num)?.toDouble(),
    json['adult'] as bool,
    json['id'] as int,
    json['original_title'] as String,
    json['overview'] as String,
    json['release_date'] as String,
    (json['revenue'] as num)?.toDouble(),
    json['runtime'] as int,
  );
}

Map<String, dynamic> _$MovieDetailsResponseToJson(
        MovieDetailsResponse instance) =>
    <String, dynamic>{
      'poster_path': instance.posterPath,
      'budget': instance.budget,
      'adult': instance.isAdult,
      'id': instance.id,
      'original_title': instance.originalTitle,
      'overview': instance.overView,
      'release_date': instance.releaseDate,
      'revenue': instance.revenue,
      'runtime': instance.minutes,
    };
