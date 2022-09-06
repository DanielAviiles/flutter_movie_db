// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:flutter_movies_db/app/modules/home/ui/widgets/carousel_card_swiper.dart';
import 'package:flutter_movies_db/app/modules/home/ui/widgets/movie_slider.dart';
import 'package:flutter_movies_db/app/modules/home/ui/widgets/search_delegate.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MoviePopularBloc movieBloc = context.read<MoviePopularBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cines'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await showSearch(
                context: context,
                delegate: MovieSearchDelegate(),
              );
            },
            icon: const Icon(Icons.search_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CarouselCardSwiper(),
            MovieSlider(
              title: 'Populares',
              onNextPage: () {
                movieBloc.getPopularMovies();
              },
            ),
          ],
        ),
      ),
    );
  }
}
