import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_searched/movie_searched.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_searched/movie_searched_bloc.dart';
import 'package:flutter_movies_db/app/modules/home/ui/bloc/movie_state.dart';
import 'package:flutter_movies_db/app/modules/home/ui/widgets/movie_item_search.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar Pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) =>
      [IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) => const Text('buildResults');

  Widget _emptyContainer() {
    return const Center(
        child: Icon(
      Icons.movie_creation_outlined,
      color: Colors.black38,
      size: 250,
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final MovieSearchedBloc movieBloc = context.read<MovieSearchedBloc>();
    if (query.isEmpty) return _emptyContainer();
    movieBloc.getSuggestionByQuery(query);
    return BlocBuilder<MovieSearchedBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieStateInit) {
          return _emptyContainer();
        } else if (state is MovieStateLoadingSearched) {
          return _indicatorLoader(size);
        } else if (state is MovieStateSearchedError) {
          return const Center(child: Text('Error al buscar pelicula'));
        } else if (state is MovieStateSearchedSuccess) {
          return ListView.builder(
            itemCount: state.searched?.length ?? state.moviesSearched?.length,
            itemBuilder: (_, int index) => MovieItemSearch(
                movie: state.searched?[index] ?? state.moviesSearched![index]),
          );
        } else {
          return _emptyContainer();
        }
      },
    );
  }

  Widget _indicatorLoader(Size size) => SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(child: CircularProgressIndicator()),
      );
}
