import 'package:flutter/material.dart';
import 'package:flutter_politburo/di/graph.dart';
import 'package:scaffold_factory/scaffold_factory.dart';

class DebugDrawerScaffoldFactory extends ScaffoldFactory {
  factory DebugDrawerScaffoldFactory(
      {@required GlobalKey<ScaffoldState> scaffoldKey,
      @required MaterialPalette materialPalette,
      dynamic event}) {
    return ScaffoldFactory(
        scaffoldKey: scaffoldKey,
        materialPalette: materialPalette,
        event: event);
  }

  @override
  Widget build(Widget bodyWidget) {
    if (appBarVisibility && nestedAppBarVisibility) {
      throw Exception(
          "Both app bar widget and nested app bar widget are being used simultaneously. \n" +
              "Make app bar widget or nested app bar widget invisible for resolving this issue.");
    }

    /// Creates a visual scaffold for material design widgets.
    return Scaffold(
      key: scaffoldKey,
      primary: primary,
      appBar: this.appBarVisibility ? this.appBar : null,
      floatingActionButtonLocation: fabLocation,
      bottomNavigationBar:
      this.bottomNavigationBarVisibility ? this.bottomNavigationBar : null,
      drawer: this.drawerVisibility ? this.drawer : null,
      endDrawer: ObjectGraph.graph.debugDrawer,
      floatingActionButton: this.floatingActionButtonVisibility
          ? this.floatingActionButton
          : null,
      body: Container(
        decoration: BoxDecoration(
          color: backgroundType == BackgroundType.solidColor
              ? backgroundColor ?? colorPalette.primaryColor
              : null,
          gradient: backgroundType == BackgroundType.gradient
              ? LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientBackgroundColors,
          )
              : null,
        ),
        child: nestedAppBarVisibility ? this.nestedAppBar : bodyWidget,
      ),
    );
  }
}
