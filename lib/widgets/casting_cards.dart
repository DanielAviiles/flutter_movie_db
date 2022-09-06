/* import 'package:flutter/cupertino.dart';
import 'package:flutter_movies_db/app/data/models/cast/cast_model.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  const CastingCards(this.movieId);
  final int movieId;

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
        future: moviesProvider.getMovieCast(movieId),
        builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              constraints: const BoxConstraints(maxWidth: 150),
              height: 180,
              child: const CupertinoActivityIndicator(),
            );
          }
          final List<Cast> cast = snapshot.data!;

          return Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            child: ListView.builder(
              itemCount: cast.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) => _CastCard(cast[index]),
            ),
          );
        });
  }
}

class _CastCard extends StatelessWidget {
  final Cast cast;
  const _CastCard(this.cast);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(cast.fullActorImg),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Text(
              cast.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
 */