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
  MoviesProvider movies = Get.put(MoviesProvider());
  List<MovieModel> popular_movies = <MovieModel>[];

  fetchMovies() async {
    var data = await MoviesProvider.getMovies();

    setState(() {
      List<dynamic> results = data['results'];
      results.forEach((element) {
        popular_movies.add(MovieModel.fromJson(element));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMovies();
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
                          itemCount: popular_movies.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                                  image: NetworkImage(movies.imagePath + popular_movies[index].posterPath!),
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
                    Text("Popular Movies",
                    style: TextStyle(
                        color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                    Container(
                      height: 200,
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
