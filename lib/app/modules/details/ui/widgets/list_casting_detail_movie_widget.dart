import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_db/app/modules/details/ui/bloc/detail_bloc.dart';
import 'package:flutter_movies_db/app/modules/details/ui/bloc/detail_state.dart';
import 'package:flutter_movies_db/app/modules/details/ui/widgets/actor_card_casting_widget.dart';

class ListCastingDetailMovie extends StatelessWidget {
  const ListCastingDetailMovie(this.movieId);
  final int movieId;

  @override
  Widget build(BuildContext context) {
    final castBloc = context.read<DetailMovieBloc>();
    castBloc.getMovieCast('$movieId');
    return BlocBuilder<DetailMovieBloc, CastState>(
      builder: (ctx, state) {
        if (state is CastStateInit) {
          return _indicatorLoader();
        } else if (state is CastStateLoading) {
          return _indicatorLoader();
        } else if (state is CastStateError) {
          return Center(child: Text('Fallo al encontrar casting'));
        } else if (state is CastStateSuccess) {
          return Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            child: ListView.builder(
              itemCount: state.casting!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) =>
                  ActorCardCasting(state.casting![index]),
            ),
          );
        } else {
          return Center(child: Text('Error desconocido al encontrar casting'));
        }
      },
    );
  }

  Widget _indicatorLoader() => Container(
        constraints: const BoxConstraints(maxWidth: 150),
        height: 180,
        child: const CupertinoActivityIndicator(),
      );
}
