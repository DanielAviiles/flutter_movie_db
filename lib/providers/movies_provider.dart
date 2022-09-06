/* import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_movies_db/helpers/debouncer.dart';
import 'package:flutter_movies_db/models/models.dart';
import 'package:flutter_movies_db/models/search_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = '7cd6b7b84c4d0af3b25dddfa8dc1b813';
  final String _baseUrl = 'api.themoviedb.org';
  final String _lenguage = 'es-Es';

  List<Movie> onDisplayMovies = [];
  List<Movie> onDisplayMoviesPopulars = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionStreamController =
      StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream =>
      _suggestionStreamController.stream;

  MoviesProvider() {
    // print('Inicialisado');
    getOnDispleyMovies();
    getPopularMovies();
  }
  Future<String> _getJsonData(String endPoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endPoint,
        {'api_key': _apiKey, 'language': _lenguage, 'page': '$page'});

    final response = await http.get(url);
    return response.body;
  }

  getOnDispleyMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlainResponse.fromJson(jsonData);
    // final popularMoviesResponse = PopularMoviesResponse.fromJson(response.body);
    // final Map<String,dynamic> decodedData = json.decode(response.body);
    // print(nowPlayingResponse.results[1].title);
    onDisplayMovies = nowPlayingResponse.results;
    // onDisplayMoviesPopulars = popularMoviesResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;

    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularMoviesResponse.fromJson(jsonData);

    onDisplayMoviesPopulars = [
      ...onDisplayMoviesPopulars,
      ...popularResponse.results
    ];

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = ActorsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apiKey, 'language': _lenguage, 'query': query});

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final result = await searchMovie(value);
      _suggestionStreamController.add(result);
    };
    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });
    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}
 */