import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie_model.dart';
import '../provider/movie_provider.dart';
import 'details_screen.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App - My Wishlist'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        color: Colors.black,
        child: Consumer<MovieProvider>(
          builder: (context, movieProvider, child) {
            final List<Movie> wishlist = movieProvider.wishlist;

            return wishlist.isEmpty
                ? Center(
                   child: Text(
                'Your wishlist is empty.',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            )
                : ListView.builder(
                  itemCount: wishlist.length,
                  itemBuilder: (context, index) {
                    final Movie movie = wishlist[index];

                    return Dismissible(
                      key: Key(index.toString()),
                      direction: DismissDirection.horizontal,
                      onDismissed: (direction) {
                        movieProvider.toggleWishlistStatus(movie);
                  },
                       background: Container(
                       color: Colors.red,
                         alignment: Alignment.centerRight,
                         padding: EdgeInsets.symmetric(horizontal: 10.0),
                         child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                     child: GestureDetector(
                     onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(movie: movie),
                        ),
                      );
                     },
                       child: Card(
                        color: Colors.grey,
                         child: ListTile(
                           title: Text(

                          movie.title.length > 20
                              ? '${movie.title.substring(0, 20)}...'
                              : movie.title,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                         ),
                         subtitle: Text(
                          'Year: ${movie.year} Rating: ${movie.rating}',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                         ),
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
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
