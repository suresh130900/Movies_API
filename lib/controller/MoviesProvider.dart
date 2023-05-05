
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_api/model/MovieModel.dart';
import 'package:movie_api/config/Api.dart';

class MoviesProvider extends GetxController{

  //static const String imagePathPrefix = 'https://image.tmdb.org/t/p/w500/';
  RxString imagePath = "https://image.tmdb.org/t/p/w500/".obs;

  //RxList<MovieModel> movies = <MovieModel>[].obs;
  RxList<MovieModel> latest_movies = <MovieModel>[].obs;

  static Future<Map> getMovies() async
  {
    final Response = await http.get(Uri.parse(Api.base_api));
    return jsonDecode(Response.body);
  }
  //  Future fetchMovies() async{
  //   final Response = await http.get(Uri.parse(Api.base_api));
  //   if(Response.statusCode == 200)
  //     {
  //       List<MovieModel> movies_fetched =
  //       (jsonDecode(Response.body)["results"] as List)
  //           .map((data) => MovieModel.fromJson(data))
  //           .toList();
  //       movies.value = movies_fetched;
  //     }
  //   else{
  //     throw Exception("Failed to load");
  //   }
  // }

  Future getLatestMovies() async{
     final latest_movies_response = await http.get(Uri.parse(Api.latest));
     if(latest_movies_response.statusCode == 200)
       {
         print(latest_movies_response.body);
         List<MovieModel> latest_movie_list =
         (jsonDecode(latest_movies_response.body)['results'] as List)
             .map((data) => MovieModel.fromJson(data))
             .toList();

         latest_movies.value = latest_movie_list;
       }
     else{
       throw Exception("Failed to load Latest Movies");
     }
  }
}
