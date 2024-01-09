import 'package:flutter/material.dart';
import '../models/movie_model.dart';

class DetailsScreen extends StatelessWidget {
  final Movie movie;

  DetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                movie.mediumCoverImage,
                height: 400,
                width: 300,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Text(
                movie.title,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(height: 8),
              Text(
                'Rating: ${movie.rating}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Year: ${movie.year}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Runtime: ${movie.runtime} mins',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Genres: ${movie.genres.join(", ")}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
