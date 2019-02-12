import 'package:flutter/material.dart';

/// Represents a section of the [DebugDrawer]. Returns a list of [Widget] that
/// will be added sequentially to the [ListView] in the [Drawer]
abstract class DebugDrawerSection {
  List<Widget> build(BuildContext context);
}

class DebugDrawer extends Drawer {
  final List<DebugDrawerSection> sections;

  DebugDrawer(this.sections);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    sections.forEach((s) {
      widgets.addAll(s.build(context));
      widgets.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Divider(
          color: Colors.black,
        ),
      ));
    });

    return ListView(
      children: widgets,
    );
  }
}
