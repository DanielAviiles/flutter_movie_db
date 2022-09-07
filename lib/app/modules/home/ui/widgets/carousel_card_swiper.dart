import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_db/app/data/models/movie/movie_model.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_nowplaying/movie_general_state.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_nowplaying/movie_nowplaying_bloc.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_state.dart';
import 'package:flutter_movies_db/app/routes/app_routes.dart';

class CarouselCardSwiper extends StatelessWidget {
  const CarouselCardSwiper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<MovieNowPLayingBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieStateGeneralLoading || state is MovieStateInit) {
          return _indicatorLoader(size);
        } else if (state is MovieStateGeneralError) {
          return const Center(child: Text('Fallo al traer peliculas'));
        } else if (state is MovieStateGeneralSucces) {
          return _bodyWithMovies(size, state.movies!);
        } else {
          return const Center(child: Text('Peliculas no encontradas'));
        }
      },
    );
  }

  Widget _bodyWithMovies(Size size, List<MovieModel> movies) {
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          final MovieModel movie =
              (movies[index]).copyWith(heroId: 'swiper-${movies[index].id}');
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.details, arguments: movie);
            },
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: FadeInImage(
                  placeholder: const AssetImage("assets/no-image.jpg"),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        pagination: const SwiperPagination(builder: SwiperPagination.rect),
        itemCount: movies.length,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        layout: SwiperLayout.STACK,
      ),
    );
  }

  Widget _indicatorLoader(Size size) => SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(child: CircularProgressIndicator()),
      );
}
