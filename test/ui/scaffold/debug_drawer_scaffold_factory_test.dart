import 'package:flutter/material.dart';
import 'package:flutter_politburo/ui/scaffold/debug_drawer_scaffold_factory.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_politburo/flutter_politburo.dart';
import 'package:scaffold_factory/scaffold_factory.dart';

void main() {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  MaterialPalette _sampleColorPalette = MaterialPalette(
    primaryColor: Colors.teal,
    accentColor: Colors.redAccent,
  );

  _setupScaffoldFactory(ScaffoldFactory factory) {
    factory.appBar = factory.buildAppBar(
      titleVisibility: true,
      leadingVisibility: true,
      tabBarVisibility: false,
      titleWidget: const Text('FAB Configuration'),
      leadingWidget: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: null,
      ),
      backgroundColor: _sampleColorPalette.primaryColor,
    );
    factory.appBarVisibility = true;
    factory.nestedAppBarVisibility = false;
    factory.drawerVisibility = false;
  }

  test('correct proxying setup on DebugDrawerScaffoldFactory', () {
    final debugFactory = DebugDrawerScaffoldFactory(
      scaffoldKey: _scaffoldKey,
      materialPalette: _sampleColorPalette,
    );
    _setupScaffoldFactory(debugFactory);

    final rawFactory = ScaffoldFactory(
      scaffoldKey: _scaffoldKey,
      materialPalette: _sampleColorPalette,
    );
    _setupScaffoldFactory(rawFactory);

    expect(debugFactory.drawerVisibility, rawFactory.drawerVisibility);
    expect(debugFactory.scaffoldKey, rawFactory.scaffoldKey);
    expect(debugFactory.drawer, rawFactory.drawer);
    expect(debugFactory.drawerVisibility, rawFactory.drawerVisibility);
//    expect(debugFactory.appBar, rawFactory.appBar);
    expect(debugFactory.appBarVisibility, rawFactory.appBarVisibility);
    expect(debugFactory.nestedAppBar, rawFactory.nestedAppBar);
    expect(debugFactory.nestedAppBarVisibility, rawFactory.nestedAppBarVisibility);
    expect(debugFactory.bottomNavigationBar, rawFactory.bottomNavigationBar);
    expect(debugFactory.bottomNavigationBarVisibility, rawFactory.bottomNavigationBarVisibility);
    expect(debugFactory.primary, rawFactory.primary);
    expect(debugFactory.colorPalette, rawFactory.colorPalette);
    expect(debugFactory.backgroundType, rawFactory.backgroundType);
    expect(debugFactory.backgroundColor, rawFactory.backgroundColor);
    expect(debugFactory.gradientBackgroundColors, rawFactory.gradientBackgroundColors);
    expect(debugFactory.scaffoldFactoryBehavior, rawFactory.scaffoldFactoryBehavior);
    expect(debugFactory.textTheme, rawFactory.textTheme);
    expect(debugFactory.floatingActionButton, rawFactory.floatingActionButton);
    expect(debugFactory.floatingActionButtonVisibility, rawFactory.floatingActionButtonVisibility);
    expect(debugFactory.fabLocation, rawFactory.fabLocation);
  });
}
