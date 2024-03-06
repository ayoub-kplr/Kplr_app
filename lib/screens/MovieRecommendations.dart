import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MovieRecommendationScreen(),
    );
  }
}

class Movie {
  final String title;
  final String overview;

  Movie({required this.title, required this.overview});
}

class MovieRecommendationScreen extends StatefulWidget {
  @override
  _MovieRecommendationScreenState createState() =>
      _MovieRecommendationScreenState();
}

class _MovieRecommendationScreenState extends State<MovieRecommendationScreen> {
  late List<Movie> _movies;

  @override
  void initState() {
    super.initState();
    _movies = [];
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    final apiKey = 'YOUR_TMDB_API_KEY';
    final apiUrl =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      setState(() {
        _movies = results
            .map((movieData) => Movie(
                  title: movieData['title'],
                  overview: movieData['overview'],
                ))
            .toList();
      });
    } else {
      // Handle error
      print('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Recommendations'),
      ),
      body: _movies.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index];
                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                );
              },
            ),
    );
  }
}
