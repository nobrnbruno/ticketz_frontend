class Movie {
  final String id;
  final String title;
  final String genre;
  final String duration;
  final double rating;
  final String posterUrl;
  final String description;
  final List<String> showtimes;

  Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.duration,
    required this.rating,
    required this.posterUrl,
    required this.description,
    required this.showtimes,
  });
}
