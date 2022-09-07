import 'package:flutter/material.dart';
import 'package:flutter_movies_db/app/data/models/movie/movie_model.dart';

class AppBarDetailMovie extends StatelessWidget {
  final MovieModel movie;
  const AppBarDetailMovie(this.movie);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.red,
      expandedHeight: 200,
      floating: false,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10),
          color: Colors.black12,
          child: Text(
            movie.title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackdropimg),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
