import 'package:flutter/material.dart';
import 'package:ticketz_frontend/model/movie.dart';
import 'package:ticketz_frontend/views/home.dart';
import 'package:ticketz_frontend/views/seat_selection.dart';

void main() {
  runApp(TicketzApp());
}

class TicketzApp extends StatelessWidget {
  static const String homeRoute = '/';
  static const String seatSelectionRoute = '/seat-selection';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticketz',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: homeRoute,
      routes: {
        homeRoute: (context) => HomePage(),
        seatSelectionRoute: (context) {
          final movie = ModalRoute.of(context)!.settings.arguments as Movie;
          return SeatSelectionPage(movie: movie);
        },
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
