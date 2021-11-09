import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/src/movies/bloc/movie_cubit.dart';
import 'package:movie_app/src/movies/model/movie_model.dart';
import 'package:movie_app/src/movies/repository/movie_repository.dart';
import 'package:movie_app/src/movies/bloc/movie_state.dart';

class MockRepository extends Mock implements MovieRepository {}

void main() {
  late MockRepository movieRepository;
  late MoviesCubit moviesCubit;

  final movies = [
    MovieModel(title: 'title 01', urlImage: 'url 01', overview: '111', urlPoster: ''),
    MovieModel(title: 'title 02', urlImage: 'url 02', urlPoster: '', overview: '22222'),
  ];

  setUp(() {
    movieRepository = MockRepository();
    when(() => movieRepository.getMovies()).thenAnswer(
      (_) async => movies,
    );
  });

  test('Emits movies when repository answer correctly', () async {
    moviesCubit = MoviesCubit(repository: movieRepository);

    await expectLater(
      moviesCubit.stream,
      emits(
        LoadedState(movies),
      ),
    );
  });
}
