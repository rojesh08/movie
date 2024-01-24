
import 'package:flutter/material.dart';
import 'package:movieapp/main.dart';
import 'package:movieapp/screens/login_screen.dart';
import 'package:movieapp/services/movie_service.dart';
import '../models/movie_model.dart';



class HomeScreen extends StatelessWidget {
  final MovieService movieService = MovieService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App - Home'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final String? query =
              await showSearch(context: context, delegate: CustomSearchDelegate(movieService));
              if (query != null && query.isNotEmpty) {
                try {
                  List<Movie> searchResults = await movieService.searchMovies(query);
                  print('Search results for: $query - $searchResults');
                } catch (error) {
                  print('Error searching movies: $error');
                  // Handle error, e.g., show an error message to the user
                }
              }
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Container(
        color: Colors.black,
        child: const Center(
          child: Text(
            'Welcome to the My Movie App!',
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
      DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.red,
      ),
      child: Text(
        'Movie App',
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
      ),
    ),
          ListTile(
            leading: Icon(Icons.login_rounded,
            color:Colors.black),
              title: Text('SignUp',
                  style: TextStyle(fontSize: 20,
                  color:Colors.black)),
                onTap: () {

                Navigator.pop(context);// Closes the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
    },
          )

        ],

      )
    );

  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final MovieService movieService;

  CustomSearchDelegate(this.movieService);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
        child: FutureBuilder<List<Movie>>(
          future: movieService.searchMovies(query),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LinearProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('No results found for: $query'),
              );
            } else {
              return Container(
                  color: Colors.black,
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Movie movie = snapshot.data![index];
                      return Card(
                          child:
                          ListTile(
                            title: Text(movie.title, style: TextStyle(color:Colors.black,fontSize: 20),),
                            leading: Image.network(movie.mediumCoverImage),
                          ));
                    },
                  ));
            }
          },
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: const Center(
          child: Text(
            'Type to search...',
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
        ),
      ),
    );
  }
}