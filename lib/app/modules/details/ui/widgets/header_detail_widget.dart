import 'package:flutter/material.dart';
import 'package:flutter_movies_db/app/data/models/movie/movie_model.dart';

class HeaderDetail extends StatelessWidget {
  final MovieModel movie;
  const HeaderDetail(this.movie);

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
                  const SizedBox(width: 5),
                  Text('${movie.voteAverage}', style: textTheme.caption),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
