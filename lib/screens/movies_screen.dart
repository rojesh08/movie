import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/movie_service.dart';
import '../models/movie_model.dart';
import '../provider/movie_provider.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final MovieService _movieService = MovieService();

  @override
  void initState() {
    super.initState();

    Provider.of<MovieProvider>(context, listen: false).fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, movieProvider, child) {
        final List<Movie> movies = movieProvider.movies;
        final Movie? selectedMovie = movieProvider.selectedMovie;

        return Scaffold(
          appBar: AppBar(
            title: Text('Movie App - Movies'),
          ),
          body: Center(
            child: movies.isEmpty
                ? CircularProgressIndicator()
                : ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final Movie movie = movies[index];

                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text('Year: ${movie.year} Rating: ${movie.rating}'),
                  leading: Image.network(movie.mediumCoverImage),
                  trailing: IconButton(
                    icon: Icon(
                      movieProvider.isInWishlist(movie)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: selectedMovie == movie ? Colors.red : null,
                    ),
                    onPressed: () {
                      movieProvider.toggleWishlistStatus(movie);

                      // Select/deselect the movie
                      if (selectedMovie == movie) {
                        movieProvider.clearSelectedMovie();
                      } else {
                        movieProvider.selectMovie(movie);
                      }
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
