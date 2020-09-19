import 'package:flutter/material.dart';

class DetailTime extends StatelessWidget {
  final String name;
  final IconData icon;
  final String date;
  DetailTime(this.name, this.icon, this.date);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(name),
          subtitle: Text(date),
          trailing: Icon(
            icon,
            size: 50,
          ),
        ),
        Divider(
          color: Colors.black,
        )
      ],
    );
  }
}
