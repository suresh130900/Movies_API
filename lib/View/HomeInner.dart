import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_api/controller/MoviesProvider.dart';

class HomeInner extends StatefulWidget {
  const HomeInner({Key? key}) : super(key: key);

  @override
  State<HomeInner> createState() => _HomeInnerState();
}

class _HomeInnerState extends State<HomeInner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  MoviesProvider movies = Get.put(MoviesProvider());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    movies.fetchMovies();
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
      body: Column(
        children: [
          SizedBox(
            height: 540,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(movies.imagePath + movies.movies[0].posterPath!),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                    left: 130,
                    child: Row(
                      children: [
                        ActionChip(
                          backgroundColor: Colors.white,
                          onPressed: () {  },
                          label: Text("Watch"),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        ActionChip(
                          backgroundColor: Colors.white,
                            onPressed: () {},
                            label: Text("Details"),
                        ),
                      ],
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
