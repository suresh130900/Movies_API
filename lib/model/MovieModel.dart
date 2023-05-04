
class MovieModel {
  var id;
  var popularity;
  var original_language;
  var original_title;
  var poster_path;
  var video;
  var vote_average;
  var vote_count;
  var title;
  var backdrop_path;
  var adult;
  var genre_id;
  var overview;
  var release_date;

  MovieModel.fromJson(Map<String , dynamic> json)
      : id = json['id'],
        popularity = json['popularity'],
        original_language = json['original_language'],
        original_title = json['original_title'],
        poster_path = json['poster_path'],
        video = json['video'],
        vote_average = json['vote_average'],
        vote_count = json['vote_count'],
        title = json['title'],
        backdrop_path = json['backdrop_path'],
        adult = json['adult'],
        genre_id = json['genre_id'],
        overview = json['overview'],
        release_date = json['release_date'];
}