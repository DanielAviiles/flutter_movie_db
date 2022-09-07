import 'package:flutter/material.dart';
import 'package:flutter_movies_db/app/data/models/movie/movie_model.dart';

class OverViewMovie extends StatelessWidget {
  final MovieModel movie;
  const OverViewMovie(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
