import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_politburo/ui/component/debug_drawer.dart';
import 'package:flutter_politburo/ui/component/incubating.dart';
import 'package:fimber/fimber.dart';

/// Class that wraps a [Router] and handles registering all routes and handlers
/// in the implementation of [routeMap]
abstract class AppRouter {
  final Router router;

  AppRouter(this.router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      Fimber.w("ROUTE WAS NOT FOUND !!! [$params]");
    });
    routeMap()
        .forEach((route, handler) => router.define(route, handler: handler));
  }

  Map<String, Handler> routeMap();
}

/// Class that can take a [Map] and [Router] and create a section for the
/// [DebugDrawer] allowing a developer to navigate to all screens defined in the
/// [AppRouter.routeMap] without creating any UI as long as the app is running
/// in debug mode
class RouteEntrySection extends DebugDrawerSection {
  final Map<String, Handler> routeMap;
  final Router router;

  RouteEntrySection(this.routeMap, this.router);

  @override
  List<Widget> build(BuildContext context) => _routeEntries(context);

  List<Widget> _routeEntries(BuildContext context) {
    final List<Widget> widgets = List<Widget>.of([
      ListTile(
        title: Text(
          "Routes",
          textAlign: TextAlign.center,
        ),
      ),
    ]).followedBy(routeMap.keys.map((route) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        child: RaisedButton(
            child: Text(route),
            onPressed: () {
              router.navigateTo(context, route);
            }),
      );
    })).toList();

    return widgets;
  }
}

final incubatingHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return IncubatingScreen();
});
