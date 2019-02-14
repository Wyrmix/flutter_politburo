import 'package:flutter/material.dart';
import 'package:flutter_politburo/di/graph.dart';
import 'package:scaffold_factory/scaffold_factory.dart';

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
  Widget drawer;

  @override
  bool drawerVisibility;

  @override
  Widget bottomNavigationBar;

  @override
  bool bottomNavigationBarVisibility;

  @override
  FloatingActionButtonLocation fabLocation;

  @override
  Widget floatingActionButton;

  @override
  bool floatingActionButtonVisibility;

  @override
  NestedScrollView nestedAppBar;

  @override
  bool nestedAppBarVisibility;

  @override
  AppBar appBar;

  @override
  bool appBarVisibility;

  @override
  TextTheme textTheme;

  @override
  Color backgroundColor;

  @override
  List<Color> gradientBackgroundColors;

  @override
  BackgroundType backgroundType;

  @override
  MaterialPalette colorPalette;

  @override
  ScaffoldFactoryBehaviors scaffoldFactoryBehavior;

  @override
  bool primary;

  @override
  GlobalKey<ScaffoldState> scaffoldKey;
}
