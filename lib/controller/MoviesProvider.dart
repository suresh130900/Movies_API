
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
  RxList<MovieModel> top_rated = <MovieModel>[].obs;
  RxList<MovieModel> upcoming_movies = <MovieModel>[].obs;
  RxList<MovieModel> trending_movies = <MovieModel>[].obs;

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

  Future getTopRated() async{
    final top_rated_movies = await http.get(Uri.parse(Api.top_rated));
    if(top_rated_movies.statusCode == 200)
      {
        print("TOP Rated Movies");
        print(top_rated_movies.body);
        List<MovieModel> top_rated_list =
        (jsonDecode(top_rated_movies.body)['results'] as List)
            .map((data) => MovieModel.fromJson(data))
            .toList();

        top_rated.value = top_rated_list;
      }
    else{
      throw Exception("Failed to load Top rated movies");
    }
  }

  static Future<Map> getUpcomingMovies() async{
    final upcoming_movies_response = await http.get(Uri.parse(Api.upcoming));
    if(upcoming_movies_response.statusCode == 200)
      {
        return jsonDecode(upcoming_movies_response.body);
        // List<MovieModel> upcoming_list =
        // (jsonDecode(upcoming_movies_response.body)['results'] as List)
        //     .map((data) => MovieModel.fromJson(data))
        //     .toList();
        //
        // upcoming_movies.value = upcoming_list;
      }
    else{
      throw Exception("Failed to Load Upcoming Movies");
    }
  }

  static Future<Map> getTrending() async{
    final trending_response = await http.get(Uri.parse(Api.trending));

    if(trending_response.statusCode == 200)
      {
        return jsonDecode(trending_response.body);
      }
    else
      {
        throw Exception("Failed to Load Trending Movies");
      }
  }
}
