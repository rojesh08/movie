import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieProvider with ChangeNotifier {
  final String apiKey = '5e35a030';
  final String apiUrl = 'https://yts.mx/api/v2/list_movies.json';

  List<Movie> _movies = [];
  List<Movie> _wishlist = [];
  Movie? _selectedMovie;

  List<Movie> get movies => _movies;
  List<Movie> get wishlist => _wishlist;
  Movie? get selectedMovie => _selectedMovie;

  Future<void> fetchMovies() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('data') && data['data'].containsKey('movies')) {
          final List<dynamic> moviesData = data['data']['movies'];
          _movies = moviesData.map((movieData) => Movie.fromJson(movieData)).toList();
          notifyListeners();
        } else {
          throw Exception('API response does not contain movie data');
        }
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load movies: $error');
    }
  }

  bool isInWishlist(Movie movie) {
    return _wishlist.contains(movie);
  }

  void toggleWishlistStatus(Movie movie) {
    if (_wishlist.contains(movie)) {
      _wishlist.remove(movie);
    } else {
      _wishlist.add(movie);
    }
    notifyListeners();
  }

  void selectMovie(Movie movie) {
    _selectedMovie = movie;
    notifyListeners();
  }

  void clearSelectedMovie() {
    _selectedMovie = null;
    notifyListeners();
  }
}
