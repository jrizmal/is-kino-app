import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iskinoapp/models/Showing.dart';

class SeatReservationPage extends StatefulWidget {
  final Showing showing;
  SeatReservationPage({this.showing});
  @override
  _SeatReservationPageState createState() => _SeatReservationPageState();
}

class _SeatReservationPageState extends State<SeatReservationPage> {
  @override
  void initState() {
    log(this.widget.showing.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Hello"),
    );
  }
}
