import 'package:flutter/cupertino.dart';

class Prayer {
  final String id;
  final Map<String, dynamic> times;
  final Map<String, dynamic> location;
  final Map<String, dynamic> date;

  Prayer({
    @required this.id,
    @required this.times,
    @required this.location,
    @required this.date,
  });
}
