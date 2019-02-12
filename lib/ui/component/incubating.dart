import 'package:flutter/material.dart';

/// Placeholder to use for a screen that we want to have in the router but don't
/// have designs or a working implementation yet
class IncubatingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[600],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 32.0),
          child: Column(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Icon(
                  Icons.pregnant_woman,
                  size: 192,
                  color: Colors.yellow[700],
                ),
              ),
              Text(
                "Incubating Feature",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ));
  }
}
