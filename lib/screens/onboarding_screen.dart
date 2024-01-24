import 'package:flutter/material.dart';
import 'package:movieapp/main.dart';


class MovieOnboardingScreen extends StatefulWidget {
  @override
  _MovieOnboardingScreenState createState() => _MovieOnboardingScreenState();
}

class _MovieOnboardingScreenState extends State<MovieOnboardingScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Map<String, String>> onboardingData = [
    {
      'title': 'Discover Movies',
      'description': 'Explore a vast collection of movies in various genres.',
      'image': 'lib/assets/images/movies1.jpg',
    },
    {
      'title': 'Personalized Recommendations',
      'description': 'Get personalized movie recommendations based on your preferences.',
      'image': 'lib/assets/images/movies2.jpg',
    },
    {
      'title': 'Enjoy Watching',
      'description': 'Sit back, relax, and enjoy your favorite movies with our app.',
      'image': 'lib/assets/images/movies3.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemCount: onboardingData.length,
        itemBuilder: (context, index) {
          return MovieOnboardingPage(
            title: onboardingData[index]['title']!,
            description: onboardingData[index]['description']!,
            image: onboardingData[index]['image']!,
          );
        },
      ),
      bottomSheet: _currentPage == onboardingData.length - 1
          ? Container(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(

          onPressed: () {
            _navigateToMainApp();
          },
          child: const Text('Get Started'),
        ),
      )
          : null,
    );
  }

  void _navigateToMainApp() {
    // Dispose of the PageController to avoid issues
    _pageController.dispose();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(

        builder: (context) => MyMovieApp(),

      ),
    );
  }
}

class MovieOnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  MovieOnboardingPage({
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 300,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
