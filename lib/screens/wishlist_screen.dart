import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie_model.dart';
import '../provider/movie_provider.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App - My Wishlist'),
      ),
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          final List<Movie> wishlist = movieProvider.wishlist;

          return wishlist.isEmpty
              ? Center(
            child: Text('Your wishlist is empty.'),
          )
              : ListView.builder(
            itemCount: wishlist.length,
            itemBuilder: (context, index) {
              final Movie movie = wishlist[index];

              return ListTile(
                title: Text(movie.title),
                subtitle: Text('Year: ${movie.year} Rating: ${movie.rating}'),
                leading: Image.network(movie.mediumCoverImage),
                trailing: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    movieProvider.toggleWishlistStatus(movie);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
