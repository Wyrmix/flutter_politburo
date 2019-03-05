import 'dart:io';

import 'package:card_settings/card_settings.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_politburo/ui/component/di_widget.dart';
import 'package:flutter_politburo/ui/component/image_picker.dart';
import 'package:flutter_politburo/ui/component/incubating.dart';
import 'package:flutter_politburo/ui/scaffold/debug_drawer_scaffold_factory.dart';
import 'package:quiver/core.dart';
import 'package:sample/ui/profile/profile_vm.dart';
import 'package:scaffold_factory/scaffold_factory.dart';
import 'package:flutter_politburo/ui/component/card_settings.dart';

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
//    var body = Padding(
//      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
//      child: Form(
//          child: CardSettings(
//            children: <Widget>[
//              CardSettingsHeader(label: "Colors", labelAlign: TextAlign.center,),
//              CardSettingsColorPicker(label: 'Color',),
//              CardSettingsHeader(label: "Photos", labelAlign: TextAlign.center,),
//              CardSettingsPhotoPicker(label: 'Images', onChanged: (value) { Fimber.d("$value"); },),
//            ],
//          )),
//    );

    var body = Center(
      child: Container(
        child: ConstrainedBox(
//          constraints: BoxConstraints.loose(Size(250, 250)),
          constraints: BoxConstraints(
              minHeight: 96, minWidth: 96, maxHeight: 250, maxWidth: 250),
          child: ImagePicker(
            ImagePickerEditingController(Optional.absent()),
            _upload,
            url: "https://placekitten.com/800/800",
          ),
        ),
      ),
    );

    return _scaffoldFactory.build(body);
//    return IncubatingScreen();
  }

  Future<Optional<String>> _upload(File file) async {
    return Optional.of("https://placekitten.com/1200/1200");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    vm = container<ProfileViewModel>();
  }
}
