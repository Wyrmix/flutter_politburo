import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:auto_size_text/auto_size_text.dart';

/// Represents a section of the [DebugDrawer]. Returns a list of [Widget] that
/// will be added sequentially to the [ListView] in the [Drawer]
abstract class DebugDrawerSection {
  List<Widget> build(BuildContext context);
}

class PackageInfoDebugDrawerSection extends DebugDrawerSection {
  @override
  List<Widget> build(BuildContext context) {
    final widgets = <Widget>[
      ListTile(
        title: Text(
          "Package Info",
          textAlign: TextAlign.center,
        ),
      ),
      StreamBuilder(stream: PackageInfo.fromPlatform().asStream(), builder: (context, AsyncSnapshot<PackageInfo> snapshot) {
        return Container(child: Column(children: <Widget>[
          ListTile(
            leading: Text(
              "App",
              textAlign: TextAlign.center,
            ),
            title: AutoSizeText(
              snapshot.data.appName,
              maxLines: 1,
            ),
            subtitle: AutoSizeText(snapshot.data.packageName, maxLines: 1,),
          ),
          ListTile(
            leading: Text(
              "Version",
              textAlign: TextAlign.center,
            ),
            title: AutoSizeText(
              snapshot.data.version,
              maxLines: 1,
            ),
            subtitle: AutoSizeText("Build #${snapshot.data.buildNumber}", maxLines: 1,),
          ),
        ],),);
      },)
    ];

    return widgets;
  }
}

class DebugDrawer extends Drawer {
  final List<DebugDrawerSection> sections;

  DebugDrawer(this.sections): super();

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
