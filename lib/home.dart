
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';

class MoviesProvider {

  static const String imagePathPrefix = 'https://image.tmdb.org/t/p/w500/';

  //getJson() function to get the data in form of json from the website
  static Future<Map>  getJson() async{

    //this is the api key we got form website
    const apiKey = "1ebb48a64c8759bbe9ce69262bb88286";

    const apiEndPoint = "http://api.themoviedb.org/3/discover/movie?api_key=${apiKey}&sort_by=popularity.desc";
    // print(apiEndPoint);

    final apiResponse = await http.get(Uri.parse(apiEndPoint));
    // print(apiResponse);
    return jsonDecode(apiResponse.body);
  }
}


class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    //calling the function
    fetchMovies();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  var size,height,width;
  List<MovieModel> movies = <MovieModel>[];

  fetchMovies() async {
    var data = await MoviesProvider.getJson();

    setState(() {
      List<dynamic> results = data['results'];
      results.forEach((element) {
        movies.add(MovieModel.fromJson(element));
      });
    });
    // print(movies);
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red.shade400,
        elevation: 0,
        title: const Text("Netflix Ultra Lite",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),

        leading: const Icon(
          Icons.home,
          color: Colors.black,
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200,
              child: PageView.builder(
                //physics: NeverScrollableScrollPhysics(),
                itemCount: movies.length - 15,
                pageSnapping: true,
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(MoviesProvider.imagePathPrefix +
                            movies[i].poster_path),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  );
                }
                ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: movies == null ? 0: movies.length,

              shrinkWrap: true,
              itemBuilder: (BuildContext context,int i){
                return Column(
                  children: <Widget>[
                    MovieTile(movies,i),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MovieTile extends StatelessWidget {

  final List<MovieModel> movies;
  final index;

  const MovieTile(this.movies , this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          movies[index].poster_path != null
          ? Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 2,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey,

              image: DecorationImage(
                image: NetworkImage(MoviesProvider.imagePathPrefix +
                movies[index].poster_path),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.0,
                  offset: Offset(1.0, 3.0),
                ),
              ],
            ),
          )
          :Container(),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movies[index].title,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movies[index].overview,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

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