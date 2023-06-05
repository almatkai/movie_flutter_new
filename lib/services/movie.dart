import 'package:flutter/material.dart';
import 'package:movie_flutter_new/model/movie_details.dart';
import 'package:movie_flutter_new/model/movie_preview.dart';
import 'package:movie_flutter_new/secret/the_moviedb_api.dart' as secret;
import 'package:movie_flutter_new/utils/constants.dart';
import 'package:movie_flutter_new/utils/file_manager.dart';
import 'package:movie_flutter_new/widgets/movie_card.dart';

import 'networking.dart';

enum MoviePageType {
  popular,
  upcoming,
  top_rated,
}

class MovieModel {
  Future _getData({required String url}) async {
    NetworkHelper networkHelper = NetworkHelper(Uri.parse(url));
    var data = await networkHelper.getData();
    print(url);
    return data;
  }

  Future<List<MovieCard>> getMovies(
      {required MoviePageType moviesType,
      required Color themeColor,
      required String language}) async {
    List<MovieCard> temp = [];
    String mTypString =
        moviesType.toString().substring(14, moviesType.toString().length);

    var data = await _getData(
      url:
          '$kThemoviedbURL/$mTypString?api_key=${secret.themoviedbApi}${language}',
    );
    for (var item in data["results"]) {
      temp.add(
        MovieCard(
          moviePreview: MoviePreview(
            isFavorite:
                await isMovieInFavorites(movieID: item["id"].toString()),
            year: (item["release_date"].toString().length > 4)
                ? item["release_date"].toString().substring(0, 4)
                : "",
            imageUrl: "$kThemoviedbImageURL${item["poster_path"]}",
            title: item["title"],
            id: item["id"].toString(),
            rating: item["vote_average"].toDouble(),
            overview: item["overview"],
          ),
          themeColor: themeColor,
          language: language,
        ),
      );
    }
    return Future.value(temp);
  }

  Future<List<MovieCard>> getGenreWiseMovies(
      {required int genreId,
      required Color themeColor,
      required String language}) async {
    List<MovieCard> temp = [];

    var data = await _getData(
      url:
          '$kThemovieDiscoverdbURL?api_key=${secret.themoviedbApi}${language}&sort_by=popularity.desc&with_genres=$genreId',
    );

    for (var item in data["results"]) {
      temp.add(
        MovieCard(
          moviePreview: MoviePreview(
            isFavorite:
                await isMovieInFavorites(movieID: item["id"].toString()),
            year: (item["release_date"].toString().length > 4)
                ? item["release_date"].toString().substring(0, 4)
                : "",
            imageUrl: "$kThemoviedbImageURL${item["poster_path"]}",
            title: item["title"],
            id: item["id"].toString(),
            rating: item["vote_average"].toDouble(),
            overview: item["overview"],
          ),
          themeColor: themeColor,
          language: language,
        ),
      );
    }
    return Future.value(temp);
  }

  Future<MovieDetails> getMovieDetails(
      {required String movieID, required String language}) async {
    var data = await _getData(
      url:
          '$kThemoviedbURL/$movieID?api_key=${secret.themoviedbApi}${language}',
    );

    List<String> temp = [];
    List<int> genreIdsTemp = [];
    for (var item in data["genres"]) {
      temp.add(item["name"]);
      genreIdsTemp.add(item["id"]);
    }

    return Future.value(
      MovieDetails(
        backgroundURL:
            "https://image.tmdb.org/t/p/w500${data["backdrop_path"]}",
        title: data["title"],
        year: (data["release_date"].toString().length > 4)
            ? data["release_date"].toString().substring(0, 4)
            : "",
        isFavorite: await isMovieInFavorites(movieID: data["id"].toString()),
        rating: data["vote_average"].toDouble(),
        genres: Map.fromIterables(temp, genreIdsTemp),
        overview: data["overview"],
      ),
    );
  }

  Future<List<MovieCard>> getFavorites(
      {required Color themeColor,
      required int bottomBarIndex,
      required String language}) async {
    List<MovieCard> temp = [];
    List<String> favoritesID = await getFavoritesID();
    for (var item in favoritesID) {
      if (item != "") {
        var data = await _getData(
          url: '$kThemoviedbURL/$item?api_key=${secret.themoviedbApi}$language',
        );

        temp.add(
          MovieCard(
            contentLoadedFromPage: bottomBarIndex,
            themeColor: themeColor,
            moviePreview: MoviePreview(
              isFavorite:
                  await isMovieInFavorites(movieID: data["id"].toString()),
              year: (data["release_date"].toString().length > 4)
                  ? data["release_date"].toString().substring(0, 4)
                  : "",
              imageUrl: "https://image.tmdb.org/t/p/w500${data["poster_path"]}",
              title: data["title"],
              id: data["id"].toString(),
              rating: data["vote_average"].toDouble(),
              overview: data["overview"],
            ),
            language: language,
          ),
        );
      }
    }
    return temp;
  }
}
