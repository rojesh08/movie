class Movie {
  final String title;
  final int year;
  final double rating;
  final String mediumCoverImage;

  Movie({
    required this.title,
    required this.year,
    required this.rating,
    required this.mediumCoverImage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      year: json['year'],
      rating: json['rating'].toDouble(),
      mediumCoverImage: json['medium_cover_image'],
    );
  }
}

