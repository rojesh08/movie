import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/movies_screen.dart';
import 'screens/wishlist_screen.dart';
import 'provider/movie_provider.dart';
import 'package:movieapp/screens/onboarding_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MovieProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace the following line with your actual logic to check if onboarding is completed
    bool hasCompletedOnboarding = false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: hasCompletedOnboarding ? MyMovieApp() : MovieOnboardingScreen(),
    );
  }
}

class MyMovieApp extends StatefulWidget {
  @override
  _MyMovieAppState createState() => _MyMovieAppState();
}

class _MyMovieAppState extends State<MyMovieApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    MoviesScreen(),
    WishlistScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Movies',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'My Wishlist',
            ),

          ],
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            },
          selectedItemColor: Colors.red,
        ),
      ),
    );
  }
}
