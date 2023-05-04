
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_api/controller/MoviesProvider.dart';
import 'package:movie_api/model/MovieModel.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  MoviesProvider movies = Get.put(MoviesProvider());

  @override
  void initState() {
    super.initState();

    //calling the function
    movies.fetchMovies();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  var size,height,width;

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
                itemCount: movies.movies.length - 15,
                pageSnapping: true,
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(MoviesProvider.imagePathPrefix +
                            movies.movies[i].poster_path),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  );
                }
                ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: movies == null ? 0: movies.movies.length,

              shrinkWrap: true,
              itemBuilder: (BuildContext context,int i){
                return Column(
                  children: <Widget>[
                    MovieTile(movies.movies,i),
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
