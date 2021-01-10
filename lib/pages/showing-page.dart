import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iskinoapp/models/Movie.dart';
import 'package:http/http.dart' as http;
import 'package:iskinoapp/models/Showing.dart';
import 'package:iskinoapp/pages/seat-reservation-page.dart';

class ShowingPage extends StatefulWidget {
  final Movie movie;

  ShowingPage({this.movie});

  @override
  _ShowingPageState createState() => _ShowingPageState();
}

class _ShowingPageState extends State<ShowingPage> {
  List<Showing> showings = [];

  @override
  void initState() {
    // log(widget.movie.toString());
    this.fetchShowings();
    super.initState();
  }

  void fetchShowings() async {
    log(widget.movie.toString());
    http.Response res = await http.get(
        "https://is-kino.azurewebsites.net/api/showing/" +
            widget.movie.id.toString());
    var json = jsonDecode(res.body);
    List<Showing> showings = [];
    for (var showing in json) {
      // log(showing.toString());
      Showing s = new Showing(
          id: showing["showingID"], time: DateTime.parse(showing["startTime"]));
      // log(s.time.toString());

      showings.add(s);
    }
    showings.sort((s1, s2) {
      return s1.time.compareTo(s2.time);
    });
    setState(() {
      this.showings = showings;
    });
  }

  List<Widget> getShowingListItems(ctx) {
    List<Widget> items = [];
    if (this.showings.length <= 0) {
      items.add(Padding(
          padding: EdgeInsets.all(20),
          child: Center(
              child: Text(
            "Ta film se trenutno ne predvaja",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ))));
    }
    DateFormat df = DateFormat("d. MMMM y");
    for (Showing sh in this.showings) {
      Widget w = new Card(
        child: GestureDetector(
          onTap: () {
            Navigator.of(ctx).push(new MaterialPageRoute(builder: (ctx) {
              return SeatReservationPage();
            }));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  df.format(sh.time),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        ),
      );
      items.add(w);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Predvajanja"),
      ),
      body: ListView(
        children: getShowingListItems(context),
      ),
    );
  }
}
