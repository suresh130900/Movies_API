import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_api/controller/TvProvider.dart';

class TvShows extends StatefulWidget {
  const TvShows({Key? key}) : super(key: key);

  @override
  State<TvShows> createState() => _TvShowsState();
}

class _TvShowsState extends State<TvShows> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TvProvider tv = Get.put(TvProvider());

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
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => Image(image: NetworkImage(tv.imagePath+tv.popular_tv[1].posterPath!))),
          ],
        ),
      ),
    );
  }
}
