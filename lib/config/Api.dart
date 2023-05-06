class Api{

  //this is the api key we got form website
  static String apiKey = "1ebb48a64c8759bbe9ce69262bb88286";

  //latest popular
  static String base_api = "https://api.themoviedb.org/3/movie/popular?api_key=1ebb48a64c8759bbe9ce69262bb88286&language=en-US&page=1";
  //latest movies
  static String latest = "https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&language=en-US&";
  //Top rated API Endpoint
  static String top_rated = "https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&language=en-US";
  //upcoming movies
  static String upcoming = "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&language=en-US";
  //trending Movies
  static String trending = "https://api.themoviedb.org/3/trending/all/day?api_key=$apiKey";

}