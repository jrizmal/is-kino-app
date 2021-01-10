import 'package:flutter/material.dart';
import 'package:iskinoapp/models/Movie.dart';
import 'package:iskinoapp/pages/showing-page.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;
  MovieItem({this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {
          print("movie tapped");
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return ShowingPage(
              movie: movie,
            );
          }));
        },
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Row(
            children: [
              Image.network(
                (movie.image == null
                    ? "https://shahpourpouyan.com/wp-content/uploads/2018/10/orionthemes-placeholder-image-1.png"
                    : movie.image),
                height: 200,
                width: 100,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 180,
                      child: Text(
                        movie.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Text(movie.rating),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
