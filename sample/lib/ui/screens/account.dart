import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_settings/card_settings.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_politburo/ui/component/di_widget.dart';
import 'package:flutter_politburo/ui/component/image_picker.dart';
import 'package:flutter_politburo/ui/component/photo_viewer.dart';
import 'package:flutter_politburo/ui/scaffold/debug_drawer_scaffold_factory.dart';
import 'package:quiver/core.dart';
import 'package:sample/ui/profile/profile_vm.dart';
import 'package:scaffold_factory/scaffold_factory.dart';
import 'package:flutter_politburo/ui/component/card_settings.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> with ContainerConsumer {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  MaterialPalette _sampleColorPalette = MaterialPalette(
    primaryColor: Colors.teal,
    accentColor: Colors.redAccent,
  );

  ProfileViewModel vm;
  ScaffoldFactory _scaffoldFactory;

  @override
  void initState() {
    super.initState();
    _scaffoldFactory = DebugDrawerScaffoldFactory(
      scaffoldKey: _scaffoldKey,
      materialPalette: _sampleColorPalette,
    );
    _scaffoldFactory.appBar = _scaffoldFactory.buildAppBar(
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
    _scaffoldFactory.appBarVisibility = true;
    _scaffoldFactory.nestedAppBarVisibility = false;
    _scaffoldFactory.drawerVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    var photos = [
      "https://buildagadev.blob.core.windows.net/projects/1/photos/color_Raising_a_Flag_over_the_Reichstag.jpg",
      "https://buildagadev.blob.core.windows.net/projects/1/photos/Image%20from%20iOS%20(1).jpg",
      "https://buildagadev.blob.core.windows.net/projects/1/photos/killing_fascist_snake.png",
      "https://buildagadev.blob.core.windows.net/projects/1/photos/color_Raising_a_Flag_over_the_Reichstag.jpg",
      "https://buildagadev.blob.core.windows.net/projects/1/photos/Image%20from%20iOS%20(1).jpg",
      "https://buildagadev.blob.core.windows.net/projects/1/photos/killing_fascist_snake.png",
      "https://buildagadev.blob.core.windows.net/projects/1/photos/color_Raising_a_Flag_over_the_Reichstag.jpg",
      "https://buildagadev.blob.core.windows.net/projects/1/photos/Image%20from%20iOS%20(1).jpg",
      "https://buildagadev.blob.core.windows.net/projects/1/photos/killing_fascist_snake.png",
    ];

    final children = <Widget>[];

    children.add(CardSettingsHeader(
      label: 'Photos',
    ));
    children.add(ConstrainedBox(
      constraints: BoxConstraints.tight(Size(250, 250)),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) =>
            CachedNetworkImage(
                imageUrl: photos[index], fit: BoxFit.cover),
        itemCount: photos.length,
        autoplay: true,
        pagination: SwiperPagination(),
        control: SwiperControl(color: Colors.white),
        onTap: (index) {
          Navigator.of(context).push(
              MaterialPageRoute<PhotoViewerScreen>(
                  fullscreenDialog: true,
                  builder: (context) =>
                      PhotoViewerScreen(photos[index])));
        },
      ),
    ));

    children.add(CardSettingsHeader(
      label: 'Upload/Delete',
    ));
    var photoWidgets = photos.map((p) => ImagePicker(
      url: p,
    ));
    children.addAll(photoWidgets);
    children.add(CardSettingsPhotoPicker(_upload));

    var body = Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: CardSettings(
        labelAlign: TextAlign.center,
        shrinkWrap: true,
        children: children,
      ),
    );

//    var body = Center(
//      child: Container(
//        child: ConstrainedBox(
//          constraints: BoxConstraints(
//              minHeight: 96, minWidth: 96, maxHeight: 250, maxWidth: 250),
//          child: ImagePicker(
//            ImagePickerEditingController(Optional.absent()),
//            _upload,
//            url: "https://placekitten.com/800/800",
//          ),
//        ),
//      ),
//    );

    return _scaffoldFactory.build(body);
//    return IncubatingScreen();
  }

  Future<Optional<String>> _upload(File file) async {
    return Optional.of("https://buildagadev.blob.core.windows.net/projects/1/photos/killing_fascist_snake.png");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    vm = container<ProfileViewModel>();
  }
}
