
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MoviesProvider {

  static const String imagePathPrefix = 'https://image.tmdb.org/t/p/w500/';

  //getJson() function to get the data in form of json from the website
  static Future<Map>  getJson() async{

    //this is the api key we got form website
    const apiKey = "1ebb48a64c8759bbe9ce69262bb88286";

    const apiEndPoint = "http://api.themoviedb.org/3/discover/movie?api_key = $apiKey &sort_by = popularity.desc";
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

class _homeState extends State<home> {
  var size,height,width;

  var movies;

  fetchMovies() async {
    var data = await MoviesProvider.getJson();
    setState(() {
      movies = data['results'];
    });
  }


  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    //calling the function
    fetchMovies();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red.shade400,
        elevation: 0,
        title: const Text("netflix ultra lite",
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
        child: movies != null
            ? Text("Api response \n $movies")
               : const Text("Loading API Response"),
        // child: Column(
        //   children: <Widget>[
        //     Container(
        //       child: ListView.builder(
        //         physics: const NeverScrollableScrollPhysics(),
        //         itemCount: movies.length,
        //         shrinkWrap: true,
        //         itemBuilder: (BuildContext context,int i){
        //         return Column(
        //           children: <Widget>[
        //             Container(
        //               width: 100,
        //               height: 500,
        //               child: Image.network(movies[i]["img"].toString()),
        //             ),
        //             Text(
        //               movies[i]["title"].toString(),
        //               style: const TextStyle(
        //                   fontSize: 20,
        //                   color: Colors.black),
        //             ),
        //             Text(
        //               movies[i]["description"].toString(),
        //               style: const TextStyle(
        //                   color: Colors.black
        //               ),
        //             ),
        //           ],
        //
        //         );
        //       },
        //       ),
        //     ),
        //     movies != null
        //     ? Text("Api response \n $movies")
        //         : Text("Loading API Response"),
        //   ],
        // ),
      ),
    );
  }
}
