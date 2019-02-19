import 'dart:io';
import 'package:fimber/fimber.dart';
import 'package:image_picker/image_picker.dart' as system;
import 'package:flutter/material.dart';
import 'package:quiver/core.dart';

class ImagePicker extends StatefulWidget {
  final ImagePickerEditingController controller;

  ImagePicker(this.controller);

  @override
  _ImagePickerState createState() => _ImagePickerState();

  @override
  String toStringShort() {
    return "${controller.value}";
  }
}

class _ImagePickerState extends State<ImagePicker> {
  @override
  Widget build(BuildContext context) {
    Fimber.d("${widget.toStringShort()}");
    var hasValue = widget.controller.value.image.isPresent;
    return InkWell(
      child: Stack(
        fit: StackFit.loose,
        alignment: hasValue
            ? AlignmentDirectional.topEnd
            : AlignmentDirectional.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 32, minWidth: 32),
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: hasValue
                      ? Container(decoration: BoxDecoration(image: DecorationImage(image: FileImage(widget.controller.value.image.value), fit: BoxFit.contain)),)
                      : Container(),
                ),
              ),
            ),
          ),
          hasValue ? _clearIcon() : _addIcon(),
        ],
      ),
      onTap: () {
        if (hasValue) {
          setState(() {
            widget.controller.value = ImagePickerValue(Optional.absent());
          });
        } else {
          showDialog(context: context, builder: _showDialog);
        }
      },
    );
  }

  _clearIcon() {
    return Container(
      decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
      child: Icon(
        Icons.clear,
        color: Colors.white,
      ),
    );
  }

  _addIcon() {
    return Container(
      decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  Widget _showDialog(BuildContext context) {
    return SimpleDialog(
      title: const Text("Choose source"),
      children: <Widget>[
        ImagePickerDialogItem(
          icon: Icons.camera_alt,
          text: "Camera",
          onPressed: () {
            system.ImagePicker.pickImage(source: system.ImageSource.camera)
                .then((file) {
              setState(() {
                widget.controller.value = ImagePickerValue(Optional.of(file));
              });
            }).catchError((er) {
              setState(() {
                widget.controller.value = ImagePickerValue(Optional.absent());
              });
            });
          },
        ),
        ImagePickerDialogItem(
          icon: Icons.camera,
          text: "Gallery",
          onPressed: () {
            system.ImagePicker.pickImage(source: system.ImageSource.gallery)
                .then((file) {
              Fimber.d("Picked $file");
              setState(() {
                widget.controller.value = ImagePickerValue(Optional.of(file));
                Fimber.d("Picked ${widget.controller.value}");
              });
            }).catchError((ex) {
              setState(() {
                widget.controller.value = ImagePickerValue(Optional.absent());
              });
            });
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class ImagePickerDialogItem extends StatelessWidget {
  const ImagePickerDialogItem(
      {Key key, this.icon, this.color, this.text, this.onPressed})
      : super(key: key);

  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 36.0, color: color),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}

class ImagePickerEditingController extends ValueNotifier<ImagePickerValue> {
  ImagePickerEditingController(Optional<File> image)
      : super(ImagePickerValue(image));

  Optional<File> get image => this.value.image;

  @override
  String toString() {
    return "ImagePickerEditingController($image})";
  }
}

class ImagePickerValue {
  final Optional<File> image;

  ImagePickerValue(this.image);

  @override
  String toString() => "ImagePickerValue($image)";
}
