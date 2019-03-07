import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_politburo/ui/component/di_widget.dart';
import 'package:pinch_zoom_image/pinch_zoom_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_politburo/ui/scaffold/debug_drawer_scaffold_factory.dart';
import 'package:scaffold_factory/scaffold_factory.dart';

class PhotoViewerScreen extends StatefulWidget {
  final String _url;

  PhotoViewerScreen(this._url) {
    Fimber.d(_url);
  }

  @override
  _PhotoViewerScreenState createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends State<PhotoViewerScreen>
    with ContainerConsumer
    implements ScaffoldFactoryBehaviors {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldFactory _scaffoldFactory;

  @override
  void initState() {
    super.initState();
    _scaffoldFactory = DebugDrawerScaffoldFactory(
        scaffoldKey: _scaffoldKey, materialPalette: MaterialPalette(
        primaryColor: Colors.white,
        accentColor: Colors.black,
        darkPrimaryColor: Colors.black,
        dividerColor: Colors.black,
        iconColor: Colors.white,));
    _scaffoldFactory.appBarVisibility = true;
    _scaffoldFactory.nestedAppBarVisibility = false;
    _scaffoldFactory.drawerVisibility = false;
    _scaffoldFactory.bottomNavigationBarVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldFactory.appBar = AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => this.onBackButtonPressed(),
        ));

    return _scaffoldFactory.build(ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: MediaQuery.of(context).size.height),
      child: Container(
        color: Colors.black,
        child: Center(
          child: PinchZoomImage(
            image: CachedNetworkImage(
              imageUrl: widget._url,
            ),
            zoomedBackgroundColor: Colors.black,
            hideStatusBarWhileZooming: false,
          ),
        ),
      ),
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void onEventBusMessageReceived(dynamic event) {}

  @override
  void onFloatingActionButtonPressed() {}

  @override
  void onBackButtonPressed() {
    Navigator.of(_scaffoldKey.currentContext).pop();
  }
}
