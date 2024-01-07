import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieService {
  final String apiUrl = 'https://yts.mx/api/v2/list_movies.json';

  Future<List<Movie>> fetchMovies() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'ok') {
          final List<dynamic> moviesData = data['data']['movies'];
          final List<Movie> movies = moviesData.map((item) => Movie.fromJson(item)).toList();
          return movies;
        } else {
          throw Exception('API response does not indicate success');
        }
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load movies: $error');
    }
  }
}
