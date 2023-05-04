
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_api/model/MovieModel.dart';
import 'package:movie_api/config/Api.dart';

class MoviesProvider extends GetxController{

  static const String imagePathPrefix = 'https://image.tmdb.org/t/p/w500/';

  RxList<MovieModel> movies = <MovieModel>[].obs;
   Future fetchMovies() async{
    final Response = await http.get(Uri.parse(Api.base_api));
    print(Response.body);
    if(Response.statusCode == 200)
      {

        List<MovieModel> movies_fetched =
        (jsonDecode(Response.body)["results"] as List)
            .map((data) => MovieModel.fromJson(data))
            .toList();

        movies.value = movies_fetched;
      }
    else{
      throw Exception("Failed to load");
    }
  }
}
