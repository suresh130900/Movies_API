import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_api/config/Api.dart';
import 'package:movie_api/model/MovieModel.dart';

class TvProvider extends GetxController{

  RxString imagePath = "https://image.tmdb.org/t/p/w500/".obs;
  RxList<MovieModel> popular_tv = <MovieModel>[].obs;


  Future getPopularTv() async{
    final popular_tv_response = await http.get(Uri.parse(Api.tv_popular));

    if(popular_tv_response.statusCode == 200)
      {
        print("TV Popular");
        print(popular_tv_response.body);
        List<MovieModel> popular_list =
        (jsonDecode(popular_tv_response.body)['results'] as List)
            .map((e) => MovieModel.fromJson(e))
            .toList();

        popular_tv.value = popular_list;
      }
    else
      {
        throw Exception("Failed to load popular movies");
      }
  }
}