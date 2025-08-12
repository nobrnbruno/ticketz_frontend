import 'package:flutter/material.dart';
import 'package:ticketz_frontend/model/movie.dart';
import 'package:ticketz_frontend/views/components/movie_card.dart';

class HomePage extends StatelessWidget {
  final List<Movie> movies = [
    Movie(
      id: '1',
      title: 'Vingadores: Ultimato',
      genre: 'Ação, Aventura',
      duration: '3h 1min',
      rating: 8.4,
      posterUrl:
          'https://via.placeholder.com/300x450/FF5722/FFFFFF?text=Vingadores',
      description: 'Os heróis mais poderosos da Terra enfrentam Thanos.',
      showtimes: ['14:00', '17:30', '21:00'],
    ),
    Movie(
      id: '2',
      title: 'Coringa',
      genre: 'Drama, Crime',
      duration: '2h 2min',
      rating: 8.5,
      posterUrl:
          'https://via.placeholder.com/300x450/9C27B0/FFFFFF?text=Coringa',
      description: 'A origem sombria do icônico vilão de Gotham.',
      showtimes: ['15:00', '18:00', '21:30'],
    ),
    Movie(
      id: '3',
      title: 'Parasita',
      genre: 'Thriller, Drama',
      duration: '2h 12min',
      rating: 8.6,
      posterUrl:
          'https://via.placeholder.com/300x450/4CAF50/FFFFFF?text=Parasita',
      description: 'Uma família pobre se infiltra na vida de uma família rica.',
      showtimes: ['16:00', '19:00', '22:00'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cinema Booking'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[900]!, Colors.black],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Filmes em Cartaz',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return MovieCard(
                    movie: movies[index],
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/seat-selection',
                        arguments: movies[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
