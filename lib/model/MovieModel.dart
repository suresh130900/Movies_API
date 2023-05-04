//
// class MovieModel {
//   var id;
//   var popularity;
//   var original_language;
//   var original_title;
//   var poster_path;
//   var video;
//   var vote_average;
//   var vote_count;
//   var title;
//   var backdrop_path;
//   var adult;
//   var genre_id;
//   var overview;
//   var release_date;
//
//   MovieModel.fromJson(Map<String , dynamic> json)
//       : id = json['id'],
//         popularity = json['popularity'],
//         original_language = json['original_language'],
//         original_title = json['original_title'],
//         poster_path = json['poster_path'],
//         video = json['video'],
//         vote_average = json['vote_average'],
//         vote_count = json['vote_count'],
//         title = json['title'],
//         backdrop_path = json['backdrop_path'],
//         adult = json['adult'],
//         genre_id = json['genre_id'],
//         overview = json['overview'],
//         release_date = json['release_date'];
// }


class MovieModel {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  var voteAverage;
  int? voteCount;

  MovieModel(
      {this.adult,
        this.backdropPath,
        this.genreIds,
        this.id,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.releaseDate,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount});

  MovieModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['genre_ids'] = this.genreIds;
    data['id'] = this.id;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['release_date'] = this.releaseDate;
    data['title'] = this.title;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    return data;
  }
}
