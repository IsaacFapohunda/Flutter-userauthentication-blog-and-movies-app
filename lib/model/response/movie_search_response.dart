// class SearchMovieResponse {
//   SearchMovieResponse({
//     required this.page,
//     required this.results,
//     required this.totalPages,
//     required this.totalResults,
//   });
//
//   final int? page;
//   final List<Result> results;
//   final int? totalPages;
//   final int? totalResults;
//
//   SearchMovieResponse copyWith({
//     int? page,
//     List<Result>? results,
//     int? totalPages,
//     int? totalResults,
//   }) {
//     return SearchMovieResponse(
//       page: page ?? this.page,
//       results: results ?? this.results,
//       totalPages: totalPages ?? this.totalPages,
//       totalResults: totalResults ?? this.totalResults,
//     );
//   }
//
//   factory SearchMovieResponse.fromJson(Map<String, dynamic> json){
//     return SearchMovieResponse(
//       page: json["page"],
//       results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
//       totalPages: json["total_pages"],
//       totalResults: json["total_results"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "page": page,
//     "results": results.map((x) => x?.toJson()).toList(),
//     "total_pages": totalPages,
//     "total_results": totalResults,
//   };
//
//   @override
//   String toString(){
//     return "$page, $results, $totalPages, $totalResults, ";
//   }
// }
//
// class Result {
//   Result({
//     required this.adult,
//     required this.backdropPath,
//     required this.genreIds,
//     required this.id,
//     required this.originalLanguage,
//     required this.originalTitle,
//     required this.overview,
//     required this.popularity,
//     required this.posterPath,
//     required this.releaseDate,
//     required this.title,
//     required this.video,
//     required this.voteAverage,
//     required this.voteCount,
//   });
//
//   final bool? adult;
//   final String? backdropPath;
//   final List<int> genreIds;
//   final int? id;
//   final String? originalLanguage;
//   final String? originalTitle;
//   final String? overview;
//   final double? popularity;
//   final String? posterPath;
//   final String? releaseDate;
//   final String? title;
//   final bool? video;
//   final double? voteAverage;
//   final int? voteCount;
//
//   Result copyWith({
//     bool? adult,
//     String? backdropPath,
//     List<int>? genreIds,
//     int? id,
//     String? originalLanguage,
//     String? originalTitle,
//     String? overview,
//     double? popularity,
//     String? posterPath,
//     String? releaseDate,
//     String? title,
//     bool? video,
//     double? voteAverage,
//     int? voteCount,
//   }) {
//     return Result(
//       adult: adult ?? this.adult,
//       backdropPath: backdropPath ?? this.backdropPath,
//       genreIds: genreIds ?? this.genreIds,
//       id: id ?? this.id,
//       originalLanguage: originalLanguage ?? this.originalLanguage,
//       originalTitle: originalTitle ?? this.originalTitle,
//       overview: overview ?? this.overview,
//       popularity: popularity ?? this.popularity,
//       posterPath: posterPath ?? this.posterPath,
//       releaseDate: releaseDate ?? this.releaseDate,
//       title: title ?? this.title,
//       video: video ?? this.video,
//       voteAverage: voteAverage ?? this.voteAverage,
//       voteCount: voteCount ?? this.voteCount,
//     );
//   }
//
//   factory Result.fromJson(Map<String, dynamic> json){
//     return Result(
//       adult: json["adult"],
//       backdropPath: json["backdrop_path"],
//       genreIds: json["genre_ids"] == null ? [] : List<int>.from(json["genre_ids"]!.map((x) => x)),
//       id: json["id"],
//       originalLanguage: json["original_language"],
//       originalTitle: json["original_title"],
//       overview: json["overview"],
//       popularity: json["popularity"],
//       posterPath: json["poster_path"],
//       releaseDate: json["release_date"],
//       title: json["title"],
//       video: json["video"],
//       voteAverage: json["vote_average"],
//       voteCount: json["vote_count"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "adult": adult,
//     "backdrop_path": backdropPath,
//     "genre_ids": genreIds.map((x) => x).toList(),
//     "id": id,
//     "original_language": originalLanguage,
//     "original_title": originalTitle,
//     "overview": overview,
//     "popularity": popularity,
//     "poster_path": posterPath,
//     "release_date": releaseDate,
//     "title": title,
//     "video": video,
//     "vote_average": voteAverage,
//     "vote_count": voteCount,
//   };
//
//   @override
//   String toString(){
//     return "$adult, $backdropPath, $genreIds, $id, $originalLanguage, $originalTitle, $overview, $popularity, $posterPath, $releaseDate, $title, $video, $voteAverage, $voteCount, ";
//   }
// }