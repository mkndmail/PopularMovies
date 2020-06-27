// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    voteCount: json['vote_count'] as int,
    posterPath: json['poster_path'] as String,
    backdropPath: json['backdrop_path'] as String,
    id: json['id'] as int,
    title: json['title'] as String,
    voteAverage: (json['vote_average'] as num)?.toDouble(),
    overView: json['overview'] as String,
    releaseDate: json['release_date'] as String,
    adult: json['adult'] as bool,
    originalLanguage: json['original_language'] as String,
    originalTitle: json['original_title'] as String,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'vote_count': instance.voteCount,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'id': instance.id,
      'title': instance.title,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'vote_average': instance.voteAverage,
      'overview': instance.overView,
      'release_date': instance.releaseDate,
      'adult': instance.adult,
    };
