// screens/movies_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie_model.dart';
import '../provider/movie_provider.dart';
import 'details_screen.dart'; //
import '../services/movie_service.dart';

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
            backgroundColor: Colors.red,
          ),
          body: Container(
            color: Colors.black,
            child: Center(
              child: movies.isEmpty
                  ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red))
                  : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                  final Movie movie = movies[index];

                    return GestureDetector(
                    onTap: () {
                      if (selectedMovie == movie) {
                        movieProvider.clearSelectedMovie();
                      } else {
                        movieProvider.selectMovie(movie);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(movie: movie),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 500,
                      width: 500,
                      child: Card(
                        color: Colors.grey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Image.network(
                                movie.mediumCoverImage,
                                fit: BoxFit.cover,
                                height: 200,
                                width: 300,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(movie.title, style: TextStyle(color: Colors.white, fontSize: 15)),
                                  Text('Rating: ${movie.rating}', style: TextStyle(color: Colors.white, fontSize: 15)),
                                  Text('Year: ${movie.year}', style: TextStyle(color: Colors.white, fontSize: 15)),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    movieProvider.isInWishlist(movie)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: selectedMovie == movie ? Colors.red : null,
                                  ),
                                  onPressed: () {
                                    movieProvider.toggleWishlistStatus(movie);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
