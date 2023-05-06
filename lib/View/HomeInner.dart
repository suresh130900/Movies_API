import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_api/controller/MoviesProvider.dart';
import 'package:movie_api/model/MovieModel.dart';

class HomeInner extends StatefulWidget {
  const HomeInner({Key? key}) : super(key: key);

  @override
  State<HomeInner> createState() => _HomeInnerState();
}

class _HomeInnerState extends State<HomeInner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  //creating object of the controller
  MoviesProvider movies = Get.put(MoviesProvider());

  //Making list of movies
  List<MovieModel> popular_movies = <MovieModel>[];
  List<MovieModel> upcomingMovies = <MovieModel>[];
  List<MovieModel> trendingMovies = <MovieModel>[];


  //fetch the current movies
  fetchMovies() async {
    var data = await MoviesProvider.getMovies();

    setState(() {
      List<dynamic> results = data['results'];
      results.forEach((element) {
        popular_movies.add(MovieModel.fromJson(element));
      });
    });
  }

  //function of the upcoming movies
  upcoming_movies() async{
    //calling the function and storing the response in data
    var data = await MoviesProvider.getUpcomingMovies();

    //setting state
    setState(() {
      //making a list
      List<dynamic> results = data['results'];
      results.forEach((element) {
        upcomingMovies.add(MovieModel.fromJson(element));
      });
    });
  }

  //function of trending Movies
  trending_movies() async{
    var data = await MoviesProvider.getTrending();

    setState(() {
      List<dynamic> results = data['results'];
      results.forEach((element) {
        trendingMovies.add(MovieModel.fromJson(element));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    //calling all the functions
    fetchMovies();
    upcoming_movies();
    trending_movies();
    print(trendingMovies);
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 540,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        height: 540,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          // itemCount: movies.movies.length,
                          itemCount: trendingMovies.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                                  image: NetworkImage(movies.imagePath + trendingMovies[index].posterPath!),
                                  //image: NetworkImage(movies.imagePath+movies.movies[index].posterPath!),
                              ),
                            );
                        }),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                        left: 95,
                        child: Row(
                          children: [
                            ActionChip(
                              backgroundColor: Colors.white,
                              onPressed: () {  },
                              label: Row(
                                children: [
                                  Icon(
                                    Icons.play_arrow,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text("Watch"),
                                  SizedBox(
                                    width: 6,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            ActionChip(
                              backgroundColor: Colors.white,
                                onPressed: () {},
                                label: Row(
                                  children: [
                                    Icon(Icons.info_outline),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Text("Details")
                                  ],
                                ),
                            ),
                          ],
                        ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Now Playing",
                    style: TextStyle(
                        color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                    Container(
                      height: 230,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        //itemCount: movies.movies.length,
                          itemCount: popular_movies.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              child: Image(
                                image: NetworkImage(movies.imagePath+movies.latest_movies[index].posterPath!),
                              ),
                            ),
                          );
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Top Rated",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                      ),
                    ),
                    Container(
                      height: 230,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movies.top_rated.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                child: Image(
                                  image: NetworkImage(movies.imagePath+movies.top_rated[index].posterPath!),
                                ),
                              ),
                            );
                          },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Upcoming",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Container(
                      height: 230,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: upcomingMovies.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              child: Image(
                                image: NetworkImage(movies.imagePath + upcomingMovies[index].posterPath!),
                              ),
                            ),
                          );
                      }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
