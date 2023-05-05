import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_api/View/HomeInner.dart';
import 'package:movie_api/View/Profile.dart';
import 'package:movie_api/View/Search.dart';
import 'package:movie_api/controller/MoviesProvider.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  MoviesProvider movies = Get.put(MoviesProvider());
  int index = 0;

  @override
  void initState() {
    super.initState();
    //movies.fetchMovies();
    movies.getLatestMovies();
    setState(() {
    });
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
      bottomNavigationBar: BottomNavigationBar(

        //to change the page dynamically
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
        unselectedItemColor: Colors.white,
        unselectedFontSize: 14,
        selectedItemColor: Colors.white,
        selectedFontSize: 14,
        backgroundColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.search,
                size: 30,
                color: Colors.white,
              ),
              label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.person,
                size: 30,
                color: Colors.white,
              ),
              label: "Profile"),
        ],
      ),
      body: IndexedStack(
        index: index,
        children: const [
            HomeInner(),
            Center(
                child: Search()
            ),
            Center(
                child: Profile()
            ),
        ],
      ),
    );
  }
}
