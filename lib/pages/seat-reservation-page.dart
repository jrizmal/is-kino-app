import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:iskinoapp/models/Showing.dart';
import 'package:http/http.dart' as http;

class SeatReservationPage extends StatefulWidget {
  final Showing showing;
  SeatReservationPage({this.showing});
  @override
  _SeatReservationPageState createState() => _SeatReservationPageState();
}

class _SeatReservationPageState extends State<SeatReservationPage> {
  List<int> selectedSeats = [];
  List<int> occupiedSeats = [];

  @override
  void initState() {
    // log(this.widget.showing.id.toString());
    getOccupiedSeats();
    super.initState();
  }

  Future<void> getOccupiedSeats() async {
    http.Response res = await http.get(
        "https://is-kino.azurewebsites.net/api/seatshowing/showing/" +
            widget.showing.id.toString());
    var json = jsonDecode(res.body);
    List<int> seatsTemp = [];
    for (var seat in json) {
      seatsTemp.add(seat["seatNumber"]);
    }
    setState(() {
      this.occupiedSeats = seatsTemp;
    });
    // log(occupiedSeats.toString());
  }

  Color getCellColor(index) {
    if (occupiedSeats.contains(index)) {
      return Colors.black;
    }
    if (selectedSeats.contains(index)) {
      return Colors.red;
    } else {
      return Colors.black12;
    }
  }

  void saveSeats(ctx) async {
    log("saving seats");
    for (int seatNumber in this.selectedSeats) {
      log("Seat number: " + seatNumber.toString());
      http.Response res = await http
          .post("https://is-kino.azurewebsites.net/api/seatshowing",
              body: '{"seatNumber": ' +
                  seatNumber.toString() +
                  ',"showingID": ' +
                  widget.showing.id.toString() +
                  '}',
              headers: {
                "Content-Type": "text/json",
              })
          .timeout(
            Duration(
              seconds: 4,
            ),
          )
          .catchError((err) {
            log("error");
          });
      log(res.statusCode.toString());
    }
    await this.getOccupiedSeats();
    log("Successfully reserved seats: " + selectedSeats.toString());
    setState(() {
      this.selectedSeats = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Izberi sedeže"),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            child: GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 5,
              // Generate 100 widgets that display their index in the List.
              children: List.generate(20, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (occupiedSeats.contains(index)) {
                        return;
                      }
                      if (selectedSeats.contains(index)) {
                        selectedSeats.remove(index);
                      } else {
                        selectedSeats.add(index);
                      }
                    });
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: getCellColor(index),
                      border: Border.all(color: Colors.white),
                    ),
                  ),
                );
              }),
            ),
          ),
          Text(
            "Število izbranih sedežev: " + selectedSeats.length.toString(),
          ),
          RaisedButton(
            onPressed: () {
              this.saveSeats(context);
            },
            child: Text("Rezerviraj"),
          )
        ],
      ),
    );
  }
}
