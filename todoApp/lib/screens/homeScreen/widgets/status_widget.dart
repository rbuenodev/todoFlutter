import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  final int status;
  final String description;
  const StatusWidget(
      {required this.status, required this.description, super.key});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case 0:
        return Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          decoration: const BoxDecoration(
              color: Colors.amberAccent,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Text(description,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
        );
      case 1:
        return Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              color: Colors.green[800],
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Text(description,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        );
      case 2:
        return Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              color: Colors.red[800],
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Text(description,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        );
      case 3:
        return Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              color: Colors.blue[800],
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Text(description,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        );
      default:
        return Container();
    }
  }
}
