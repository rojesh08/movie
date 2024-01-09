class Movie {
  final String title;
  final int year;
  final double rating;
  final String mediumCoverImage;
  final int runtime;
  final List<String> genres;

  Movie({
    required this.title,
    required this.year,
    required this.rating,
    required this.mediumCoverImage,
    required this.runtime,
    required this.genres,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      year: json['year'],
      rating: json['rating'].toDouble(),
      mediumCoverImage: json['medium_cover_image'],
      runtime: json['runtime'],
      genres: List<String>.from(json['genres']),
    );
  }
}
