import 'package:flutter/material.dart';
import 'package:flutter_movies_db/app/data/models/movie/movie_model.dart';
import 'package:flutter_movies_db/app/modules/details/ui/widgets/app_bar_detail_widget.dart';
import 'package:flutter_movies_db/app/modules/details/ui/widgets/header_detail_widget.dart';
import 'package:flutter_movies_db/app/modules/details/ui/widgets/list_casting_detail_movie_widget.dart';
import 'package:flutter_movies_db/app/modules/details/ui/widgets/over_view_detail_widget.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieModel movie =
        ModalRoute.of(context)?.settings.arguments as MovieModel;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppBarDetailMovie(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              HeaderDetail(movie),
              OverViewMovie(movie),
              ListCastingDetailMovie(movie.id)
            ]),
          )
        ],
      ),
    );
  }
}
