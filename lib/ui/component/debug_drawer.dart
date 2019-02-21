import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:device_info/device_info.dart';
import 'dart:io' show Platform;

/// Represents a section of the [DebugDrawer]. Returns a list of [Widget] that
/// will be added sequentially to the [ListView] in the [Drawer]
abstract class DebugDrawerSection {
  List<Widget> build(BuildContext context);
}

class DeviceInfoDebugDrawerSection extends DebugDrawerSection {
  @override
  List<Widget> build(BuildContext context) {
    final widgets = <Widget>[];
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      widgets.add(StreamBuilder(
          stream: deviceInfo.androidInfo.asStream(),
          builder: (context, AsyncSnapshot<AndroidDeviceInfo> snapshot) {
            final info = snapshot.data;
            final text = """
isPhysicalDevice: ${info.isPhysicalDevice}
Device: ${info.device}
Model: ${info.model}
Product: ${info.product}
Brand: ${info.brand}
Manufactorure: ${info.manufacturer}
Version: ${info.version.baseOS} ${info.version.sdkInt}
ABIs: 
  32 bit ${info.supported32BitAbis} 
  64 bit ${info.supported64BitAbis}
Tags: ${info.tags}
Build: ${info.type}
            """;

            return ListTile(
              title: Text(
                "Device Info",
                textAlign: TextAlign.center,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  text,
                  maxLines: 12,
                  minFontSize: 12,
                ),
              ),
            );
          }));
    }

    if (Platform.isIOS) {
      widgets.add(StreamBuilder(
          stream: deviceInfo.iosInfo.asStream(),
          builder: (context, AsyncSnapshot<IosDeviceInfo> snapshot) {
            final info = snapshot.data;
            final text = """
isPhysicalDevice: ${info.isPhysicalDevice}
Device: ${info.name}
Model: ${info.model}
Localized Model: ${info.localizedModel}
OS: ${info.systemName} ${info.systemVersion}
UUID: ${info.identifierForVendor}
            """;

            return ListTile(
              title: Text(
                "Device Info",
                textAlign: TextAlign.center,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  text,
                  maxLines: 10,
                  minFontSize: 12,
                ),
              ),
            );
          }));
    }
    return widgets;
  }
}

class MediaQueryDebugDrawerSection extends DebugDrawerSection {
  @override
  List<Widget> build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final text = """
size: ${mq.size}
devicePixelRatio: ${mq.devicePixelRatio.toStringAsFixed(1)} 
textScaleFactor: ${mq.textScaleFactor.toStringAsFixed(1)}
padding: ${mq.padding}
viewInsets: ${mq.viewInsets} 
alwaysUse24HourFormat: ${mq.alwaysUse24HourFormat} 
accessibleNavigation: ${mq.accessibleNavigation}
disableAnimations: ${mq.disableAnimations}
invertColors: ${mq.invertColors}
boldText: ${mq.boldText}
    """;

    final widgets = <Widget>[
      ListTile(
        title: Text(
          "MediaQuery",
          textAlign: TextAlign.center,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AutoSizeText(
            text,
            maxLines: 10,
            minFontSize: 12,
          ),
        ),
      ),
    ];
    return widgets;
  }
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
      StreamBuilder(
        stream: PackageInfo.fromPlatform().asStream(),
        builder: (context, AsyncSnapshot<PackageInfo> snapshot) {
          if (snapshot.data == null) return Container();

          return Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Text(
                    "App",
                    textAlign: TextAlign.center,
                  ),
                  title: AutoSizeText(
                    snapshot.data.appName,
                    maxLines: 1,
                  ),
                  subtitle: AutoSizeText(
                    snapshot.data.packageName,
                    maxLines: 1,
                  ),
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
                  subtitle: AutoSizeText(
                    "Build #${snapshot.data.buildNumber}",
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          );
        },
      )
    ];

    return widgets;
  }
}

class DebugDrawer extends Drawer {
  final List<DebugDrawerSection> sections;

  DebugDrawer(this.sections) : super();

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
