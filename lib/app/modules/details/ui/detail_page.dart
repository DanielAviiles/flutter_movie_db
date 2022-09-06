import 'package:flutter/material.dart';
import 'package:flutter_movies_db/app/data/models/movie/movie_model.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieModel movie =
        ModalRoute.of(context)?.settings.arguments as MovieModel;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //son widgets que tienen cierto comportamiento preprogramdo cuando se  hace scroll en el contenido del padre
          _CustomAppBar(movie),
          SliverList(
              delegate: SliverChildListDelegate([
            _PosterAndTitle(movie),
            _OverView(movie),
            // CastingCards(movie.id)
          ]))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final MovieModel movie;
  const _CustomAppBar(
    this.movie,
  );

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

class _PosterAndTitle extends StatelessWidget {
  final MovieModel movie;
  const _PosterAndTitle(
    this.movie,
  );

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: SizedBox(
              width: size.width * .2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * .55,
                child: Text(
                  movie.title,
                  style: textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              SizedBox(
                  width: size.width * .5,
                  child: Text(
                    movie.originalTitle,
                    style: textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )),
              Row(
                children: [
                  const Icon(Icons.star_outline, size: 15, color: Colors.grey),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${movie.voteAverage}',
                    style: textTheme.caption,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  final MovieModel movie;
  const _OverView(
    this.movie,
  );

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
