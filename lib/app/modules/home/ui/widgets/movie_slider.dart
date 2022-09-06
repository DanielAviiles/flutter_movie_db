import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_popular/movie_populars_state.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_state.dart';
import 'package:flutter_movies_db/app/modules/home/ui/widgets/movie_poster.dart';

class MovieSlider extends StatefulWidget {
  final String? title;
  final void Function()? onNextPage;

  const MovieSlider({
    Key? key,
    this.title,
    this.onNextPage,
  }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (widget.onNextPage != null) widget.onNextPage!();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.title != null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.title ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * .02),
          Expanded(
            child: BlocBuilder<MoviePopularBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieStateInit) {
                  return _indicatorLoader(size);
                } else if (state is MovieStatePopularError) {
                  return const Center(
                      child: Text('Fallo al traer peliculas populares'));
                } else if (state is MovieStatePopularsSuccess) {
                  return ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        state.populars?.length ?? state.moviesPopulars?.length,
                    itemBuilder: (_, int index) =>
                        MoviePoster(populars: state.populars![index]),
                  );
                } else {
                  return const Center(child: Text('Peliculas no encontradas'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _indicatorLoader(Size size) => SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(child: CircularProgressIndicator()),
      );
}
