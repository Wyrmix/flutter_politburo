import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_politburo/di/graph.dart';
import 'package:scaffold_factory/scaffold_factory.dart';
import 'package:event_bus/event_bus.dart';

//class DebugScaffoldFactory extends ScaffoldFactory {
//  factory DebugScaffoldFactory(
//      {@required GlobalKey<ScaffoldState> scaffoldKey,
//        @required MaterialPalette materialPalette,
//        dynamic event}) =>
//      DebugScaffoldFactory._internal(
//          scaffoldKey: scaffoldKey,
//          colorPalette: materialPalette,
//          event: event);
//
//  StreamSubscription _eventBusSubscription;
//
//  DebugScaffoldFactory._internal(
//      {@required scaffoldKey,
//        @required colorPalette,
//        dynamic event}) {
//    _eventBusSubscription = eventBus.on<dynamic>().listen((event) async {
//      if (event != null)
//        this.scaffoldFactoryBehavior.onEventBusMessageReceived(event);
//    });
//  }
//}

class DebugDrawerScaffoldFactory implements ScaffoldFactory {
  ScaffoldFactory _factory;

  DebugDrawerScaffoldFactory(
      {@required GlobalKey<ScaffoldState> scaffoldKey,
      @required MaterialPalette materialPalette,
      dynamic event}) {
    _factory = ScaffoldFactory(
        scaffoldKey: scaffoldKey,
        materialPalette: materialPalette,
        event: event);
  }

  @override
  Widget build(Widget bodyWidget) {
    if (this.appBarVisibility && this.nestedAppBarVisibility) {
      throw Exception(
          "Both app bar widget and nested app bar widget are being used simultaneously. \n" +
              "Make app bar widget or nested app bar widget invisible for resolving this issue.");
    }

    /// Creates a visual scaffold for material design widgets.
    return Scaffold(
      key: this.scaffoldKey,
      primary: this.primary,
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
          color: this.backgroundType == BackgroundType.solidColor
              ? this.backgroundColor ?? this.colorPalette.primaryColor
              : null,
          gradient: backgroundType == BackgroundType.gradient
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: this.gradientBackgroundColors,
                )
              : null,
        ),
        child: this.nestedAppBarVisibility ? this.nestedAppBar : bodyWidget,
      ),
    );
  }

  @override
  void launchURL(String url) => _factory.launchURL(url);

  @override
  void showSnackBar(
          {@required SnackBarMessageType messageType,
          @required bool iconVisibility,
          String message = "",
          Duration duration,
          Color backgroundColor = Colors.black,
          Color textColor = Colors.white,
          Color iconColor = Colors.white,
          TextDirection textDirection = TextDirection.ltr,
          TextStyle style}) =>
      _factory.showSnackBar(
          messageType: messageType, iconVisibility: iconVisibility);

  @override
  void dispose() {}

  @override
  void updateAndroidFrameColor(
          {Color statusBarColor, Color navigationBarColor}) =>
      _factory.updateAndroidFrameColor(
          statusBarColor: statusBarColor,
          navigationBarColor: navigationBarColor);

  @override
  FloatingActionButton buildFloatingActionButton(
          {@required Widget fabBody,
          String tooltip = "",
          String heroTag = "",
          Color backgroundColor,
          bool mini = false}) =>
      _factory.buildFloatingActionButton(
          fabBody: fabBody,
          tooltip: tooltip,
          heroTag: heroTag,
          backgroundColor: backgroundColor,
          mini: mini);

  @override
  Widget buildBottomAppBar(
          {@required Widget child,
          bool showNotch = false,
          Color color,
          Color splashColor}) =>
      _factory.buildBottomAppBar(
          child: child,
          showNotch: showNotch,
          color: color,
          splashColor: splashColor);

  @override
  Widget buildBottomNavigationBar(
          {Key key,
          @required List<BottomNavigationBarItem> items,
          @required ValueChanged<int> onTap,
          int currentIndex = 0,
          Color color,
          double iconSize,
          BottomNavigationBarType type}) =>
      _factory.buildBottomNavigationBar(
          items: items,
          onTap: onTap,
          key: key,
          currentIndex: currentIndex,
          color: color,
          type: type);

  @override
  NestedScrollView buildNestedScrollView(
          {Key key,
          @required bool titleVisibility,
          @required bool leadingVisibility,
          @required bool tabBarVisibility,
          @required Widget bodyWidget,
          bool scrollableTab,
          List<Widget> tabWidgetList,
          List<Widget> actions,
          TabController tabController,
          Widget titleWidget,
          Widget leadingWidget,
          Color backgroundColor,
          bool centerTitle = false,
          bool floating = false}) =>
      _factory.buildNestedScrollView(
          titleVisibility: titleVisibility,
          leadingVisibility: leadingVisibility,
          tabBarVisibility: tabBarVisibility,
          bodyWidget: bodyWidget,
          key: key,
          backgroundColor: backgroundColor,
          actions: actions,
          centerTitle: centerTitle,
          floating: floating,
          leadingWidget: leadingWidget,
          scrollableTab: scrollableTab,
          tabController: tabController,
          tabWidgetList: tabWidgetList,
          titleWidget: titleWidget);

  @override
  AppBar buildAppBar(
          {Key key,
          @required bool titleVisibility,
          @required bool leadingVisibility,
          @required bool tabBarVisibility,
          Widget titleWidget,
          Widget leadingWidget,
          Color backgroundColor,
          bool centerTitle = false,
          bool scrollableTab,
          TabController tabController,
          List<Widget> tabWidgetList,
          List<Widget> actions}) =>
      _factory.buildAppBar(
          titleVisibility: titleVisibility,
          leadingVisibility: leadingVisibility,
          tabBarVisibility: tabBarVisibility,
          titleWidget: titleWidget,
          tabWidgetList: tabWidgetList,
          tabController: tabController,
          scrollableTab: scrollableTab,
          leadingWidget: leadingWidget,
          centerTitle: centerTitle,
          actions: actions,
          backgroundColor: backgroundColor,
          key: key);

  @override
  void init(
          {@required bool appBarVisibility,
          @required bool floatingActionButtonVisibility,
          @required bool bottomNavigationBarVisibility,
          @required bool nestedAppBarVisibility,
          @required bool drawerVisibility,
          BackgroundType backgroundType = BackgroundType.normal,
          Widget floatingActionButton,
          FloatingActionButtonLocation floatingActionButtonLocation,
          AppBar appBar,
          NestedScrollView nestedAppBar,
          Widget drawer,
          Widget bottomNavigationBar,
          List<Color> gradientBackgroundColors,
          Color backgroundColor}) =>
      _factory.init(
          appBarVisibility: appBarVisibility,
          floatingActionButtonVisibility: floatingActionButtonVisibility,
          bottomNavigationBarVisibility: bottomNavigationBarVisibility,
          nestedAppBarVisibility: nestedAppBarVisibility,
          drawerVisibility: drawerVisibility,
          backgroundColor: backgroundColor,
          appBar: appBar,
          backgroundType: backgroundType,
          bottomNavigationBar: bottomNavigationBar,
          drawer: drawer,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          gradientBackgroundColors: gradientBackgroundColors,
          nestedAppBar: nestedAppBar);

  @override
  Widget get drawer => _factory.drawer;

  @override
  set drawer(Widget drawer) => _factory.drawer = drawer;

  @override
  bool get drawerVisibility => _factory.drawerVisibility;

  @override
  set drawerVisibility(bool visible) => _factory.drawerVisibility = visible;

  @override
  Widget get bottomNavigationBar => _factory.bottomNavigationBar;

  @override
  set bottomNavigationBar(Widget bottomNav) => _factory.bottomNavigationBar = bottomNav;

  @override
  bool get bottomNavigationBarVisibility => _factory.bottomNavigationBarVisibility;

  @override
  set bottomNavigationBarVisibility(bool visible) => _factory.bottomNavigationBarVisibility = visible;

  @override
  FloatingActionButtonLocation get fabLocation => _factory.fabLocation;

  @override
  set fabLocation(FloatingActionButtonLocation location) => _factory.fabLocation = location;

  @override
  Widget get floatingActionButton => _factory.floatingActionButton;

  @override
  set floatingActionButton(Widget  fab) => _factory.floatingActionButton = fab;

  @override
  bool get floatingActionButtonVisibility => _factory.floatingActionButtonVisibility;

  @override
  set floatingActionButtonVisibility(bool visible) => _factory.floatingActionButtonVisibility = visible;

  @override
  NestedScrollView get nestedAppBar => _factory.nestedAppBar;

  @override
  set nestedAppBar(NestedScrollView nestedAppBar) => _factory.nestedAppBar = nestedAppBar;

  @override
  bool get nestedAppBarVisibility => _factory.nestedAppBarVisibility;

  @override
  set nestedAppBarVisibility(bool visible) => _factory.nestedAppBarVisibility = visible;

  @override
  AppBar get appBar => _factory.appBar;

  @override
  set appBar(AppBar appBar) => _factory.appBar = appBar;

  @override
  bool get appBarVisibility => _factory.appBarVisibility;

  @override
  set appBarVisibility(bool visible) => _factory.appBarVisibility = visible;

  @override
  TextTheme get textTheme => _factory.textTheme;

  @override
  set textTheme(TextTheme theme) => _factory.textTheme = theme;

  @override
  Color get backgroundColor => _factory.backgroundColor;

  @override
  set backgroundColor(Color bg) => _factory.backgroundColor = bg;

  @override
  List<Color> get gradientBackgroundColors => _factory.gradientBackgroundColors;

  @override
  set gradientBackgroundColors(List<Color> colors) => _factory.gradientBackgroundColors = colors;

  @override
  BackgroundType get backgroundType => _factory.backgroundType;

  @override
  set backgroundType(BackgroundType type) => _factory.backgroundType = type;

  @override
  MaterialPalette get colorPalette => _factory.colorPalette;

  @override
  set colorPalette(MaterialPalette palette) => _factory.colorPalette = palette;

  @override
  ScaffoldFactoryBehaviors get scaffoldFactoryBehavior => _factory.scaffoldFactoryBehavior;

  @override
  set scaffoldFactoryBehavior(ScaffoldFactoryBehaviors behavior) => _factory.scaffoldFactoryBehavior = behavior;

  @override
  bool get primary => _factory.primary;

  @override
  set primary(bool primary) => _factory.primary = primary;

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _factory.scaffoldKey;

  @override
  set scaffoldKey(GlobalKey<ScaffoldState> key) => _factory.scaffoldKey = key;
}
