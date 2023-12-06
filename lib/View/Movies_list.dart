import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../controller/MoviesProvider.dart';
import 'MovieDetails.dart';


class Movies_list extends StatefulWidget {
  const Movies_list({super.key});

  @override
  State<Movies_list> createState() => _Movies_listState();
}

class _Movies_listState extends State<Movies_list> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  MoviesProvider movies = Get.put(MoviesProvider());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        //itemCount: movies.movies.length,
        itemCount: movies.latest_movies.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: GestureDetector(
                onTap: () {
                  Get.to(MoviesDetails());
                },
                child: Image(
                  image: NetworkImage(movies.imagePath+movies.latest_movies[index].posterPath!),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
