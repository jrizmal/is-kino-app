import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iskinoapp/models/Movie.dart';
import './components/movie-item.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kino Aplikacija',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'Filmi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> movies = [];

  _MyHomePageState() {
    fetchMovies();
  }

  void fetchMovies() async {
    http.Response res =
        await http.get("https://is-kino.azurewebsites.net/api/movie");
    var json = jsonDecode(res.body);
    print(json);
    List<Movie> mvs = [];
    for (var m in json) {
      mvs.add(
        Movie(
          title: m["title"],
          rating: m["rating"],
          id: m["movieID"],
        ),
      );
    }
    setState(() {
      this.movies = mvs;
    });
  }

  List<Widget> getMovieList() {
    print("movie list building");
    List<Widget> moviesItems = [];
    for (Movie movie in this.movies) {
      // print(movie);
      moviesItems.add(new MovieItem(
        movie: movie,
      ));
    }
    return moviesItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: getMovieList(),
      ),
    );
  }
}
