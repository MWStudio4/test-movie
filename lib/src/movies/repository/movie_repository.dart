import 'package:dio/dio.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/src/movies/model/movie_model.dart';

class MovieRepository {
  const MovieRepository(this.client);

  final Dio client;

  Future<List<MovieModel>> getMovies() async {
    try {
      final url =
          'https://api.themoviedb.org/3/discover/movie?api_key=a09ee7e7a2bae5f07177a9f0d8600ac7&language=ru-RU&sort_by=popularity.desc';

      final response = await client.get(url);

      logger.d(response.data['results']);

      final movies = List<MovieModel>.of(
        response.data['results'].map<MovieModel>(
          (json) => MovieModel(
            title: json['title'],
            urlImage: 'https://image.tmdb.org/t/p/w185${json['poster_path']}',
            urlPoster: 'https://image.tmdb.org/t/p/original${json['poster_path']}',
            overview: json['overview'],
          ),
        ),
      );

      return movies;
    } catch (e) {
      throw e;
    }
  }
}
