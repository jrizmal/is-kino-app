import 'package:flutter/material.dart';
import 'package:iskinoapp/models/Movie.dart';
import 'package:iskinoapp/pages/showing-page.dart';

class MovieItem extends StatelessWidget {
  Movie movie;
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
                "https://cdn.shopify.com/s/files/1/0057/3728/3618/products/950e439404c3d5eddd86ae876cec83bf_949b5045-2503-4883-bcd2-ff1f31f5b14c_240x360_crop_center.progressive.jpg",
                height: 200,
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
