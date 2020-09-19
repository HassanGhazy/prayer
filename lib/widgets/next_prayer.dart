import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NextPrayer extends StatelessWidget {
  final String name;
  final IconData icon;
  final String date;
  NextPrayer(this.name, this.icon, this.date);
  @override
  Widget build(BuildContext context) {
    String dateNow = DateFormat("yyyy-MM-dd HH:MM").format(DateTime.now());
    String newDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String tempDate = newDate + ' ' + date;
    final mediaQuery = MediaQuery.of(context);

    final min =
        DateTime.parse(tempDate).difference(DateTime.parse(dateNow)).inMinutes %
            60;
    final hour =
        DateTime.parse(tempDate).difference(DateTime.parse(dateNow)).inHours;

      
    return Container(
      color: Colors.blue[800],
      height: mediaQuery.size.height * .12,
      child: ListTile(
        title: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Time until next prayer: $hour hour $min minutes',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        trailing: Icon(
          icon,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
