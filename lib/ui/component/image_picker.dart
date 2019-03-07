import 'dart:io';
import 'package:fimber/fimber.dart';
import 'package:image_picker/image_picker.dart' as system;
import 'package:flutter/material.dart';
import 'package:quiver/core.dart';
import 'package:sealed_unions/sealed_unions.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImagePicker extends StatefulWidget {
  final String url;

  ImagePicker({this.url = ''});

  @override
  _ImagePickerState createState() => _ImagePickerState();

  @override
  String toStringShort() {
    return "$url";
  }
}

class _ImagePickerState extends State<ImagePicker> {
  ImagePickerBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ImagePickerBloc>(context);
    if (widget.url != null) {
      if (widget.url.isNotEmpty) {
        bloc.dispatch(ImagePickerEvent.success(widget.url));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, ImagePickerState state) {
        return state.join(
            (empty) => _emptyInkwell(),
            (file) => _fileInkwell(file.file),
            (url) => _networkInkwell(url.url),
            (uploading) => _loadingInkwell(uploading.file),
            (success) => _uploadedInkwell(success.url),
            (error) => _failedInkwell());
      },
    );
  }

  Widget _emptyInkwell() {
    return InkWell(
      child: Stack(
        fit: StackFit.loose,
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 32, minWidth: 32),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(),
                ),
              ),
            ),
          ),
          _addIcon(),
        ],
      ),
      onTap: () {
        showDialog(context: context, builder: _showDialog);
      },
    );
  }

  Widget _fileInkwell(File file) {
    return _imageInkwell(FileImage(file));
  }

  Widget _networkInkwell(String url) {
    return _imageInkwell(CachedNetworkImageProvider(url,
        errorListener: () => bloc
            .dispatch(ImagePickerEvent.failed("Cached image failed to load"))));
  }

  Widget _imageInkwell(ImageProvider provider) {
    return InkWell(
      child: Stack(
        fit: StackFit.loose,
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 32, minWidth: 32),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: provider, fit: BoxFit.contain)),
                  ),
                ),
              ),
            ),
          ),
          _clearIcon(),
        ],
      ),
      onTap: () {
        setState(() {
          bloc.dispatch(ImagePickerEvent.cleared());
        });
      },
    );
  }

  Widget _loadingInkwell(File file) {
    return InkWell(
      child: Stack(
        fit: StackFit.loose,
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 32, minWidth: 32),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(file), fit: BoxFit.contain)),
                  ),
                ),
              ),
            ),
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget _uploadedInkwell(String url) {
    return InkWell(
      child: Stack(
        fit: StackFit.loose,
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 32, minWidth: 32),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(url), fit: BoxFit.contain)),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration:
                BoxDecoration(color: Colors.green, shape: BoxShape.circle),
            child: Icon(
              Icons.check,
              color: Colors.black,
            ),
          ),
        ],
      ),
      onTap: () {
        setState(() {
          showDialog(context: context, builder: _showDialog);
        });
      },
    );
  }

  Widget _failedInkwell() {
    return InkWell(
      child: Stack(
        fit: StackFit.loose,
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 32, minWidth: 32),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(),
                ),
              ),
            ),
          ),
          Container(
            decoration:
                BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: Icon(
              Icons.error,
              color: Colors.black,
            ),
          ),
        ],
      ),
      onTap: () {
        showDialog(context: context, builder: _showDialog);
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
            Navigator.of(context, rootNavigator: true).pop('dialog');
            system.ImagePicker.pickImage(source: system.ImageSource.camera)
                .then((file) {
              setState(() {
                bloc.dispatch(ImagePickerEvent.file(file));
              });
            }).catchError((er) {
              setState(() {
                bloc.dispatch(ImagePickerEvent.failed(er));
              });
            });
          },
        ),
        ImagePickerDialogItem(
          icon: Icons.camera,
          text: "Gallery",
          onPressed: () {
//            Navigator.of(context, rootNavigator: true).pop('dialog');
            system.ImagePicker.pickImage(source: system.ImageSource.gallery)
                .then((file) {
              Fimber.d("Picked $file");
              setState(() {
                if (file == null) {
                  bloc.dispatch(ImagePickerEvent.cleared());
                } else {
                  bloc.dispatch(ImagePickerEvent.file(file));
                }
                Fimber.d("Picked ${bloc.currentState}");
              });
            }).catchError((ex) {
              setState(() {
                bloc.dispatch(ImagePickerEvent.failed(ex));
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

typedef ImageUploader = Future<Optional<String>> Function(File file);

class ImagePickerValue {
  final Optional<File> file;

  ImagePickerValue(this.file);
}

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImageUploader uploader;
  ImagePickerState initial;

  ImagePickerBloc(this.uploader, {this.initial});

  @override
  ImagePickerState get initialState => this.initial ?? ImagePickerState.empty();

  @override
  Stream<ImagePickerState> mapEventToState(
      ImagePickerState currentState, ImagePickerEvent event) async* {
    yield event.join(
        (c) => _fileCleared(currentState),
        (f) => _filePicked(currentState, f.file),
        (u) => _uploadStarted(currentState),
        (u) => _uploadSuccess(currentState, u.url),
        (f) => _failed(currentState, f.ex));
  }

  @override
  void onTransition(Transition<ImagePickerEvent, ImagePickerState> transition) {
    var e = transition.event;
    var s = transition.currentState;
    Fimber.d("Transition [$e] => [$s]");
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    Fimber.e('Error in ImagePickerBloc', ex: error, stacktrace: stacktrace);
    if (error is Exception) {
      dispatch(ImagePickerEvent.failed(error));
    }
  }

  ImagePickerState _fileCleared(ImagePickerState currentState) {
    return ImagePickerState.empty();
  }

  ImagePickerState _filePicked(ImagePickerState currentState, File file) {
    uploader(file)
        .then((o) =>
            o.ifPresent((s) => this.dispatch(ImagePickerEvent.success(s))))
        .catchError((e) => this.dispatch(ImagePickerEvent.failed(e)));

    this.dispatch(ImagePickerEvent.upload());
    return ImagePickerState.file(file);
  }

  ImagePickerState _uploadStarted(ImagePickerState currentState) {
    return currentState.join(
        (empty) => ImagePickerState.empty(),
        (file) => ImagePickerState.uploading(file.file),
        (url) => ImagePickerState.success(url.url),
        (uploading) => ImagePickerState.uploading(uploading.file),
        (success) => ImagePickerState.success(success.url),
        (error) => ImagePickerState.error(error.ex));
  }

  ImagePickerState _uploadSuccess(ImagePickerState currentState, String url) {
    return currentState.join(
        (_) => ImagePickerState.url(url),
        (_) => ImagePickerState.success(url),
        (_) => ImagePickerState.success(url),
        (_) => ImagePickerState.success(url),
        (i) => ImagePickerState.success(i.url),
        (_) => ImagePickerState.success(url));
  }

  ImagePickerState _failed(ImagePickerState currentState, Object ex) {
    Fimber.e('Error with current state $currentState', ex: ex ?? {});
    return ImagePickerState.error(ex);
  }
}

class ImagePickerEvent extends Union5Impl<
    ImagePickerEventCleared,
    ImagePickerEventFileSelected,
    ImagePickerEventUploadStarted,
    ImagePickerEventUploadSuccess,
    ImagePickerEventUploadFailed> {
  static final _factory = Quintet<
      ImagePickerEventCleared,
      ImagePickerEventFileSelected,
      ImagePickerEventUploadStarted,
      ImagePickerEventUploadSuccess,
      ImagePickerEventUploadFailed>();

  ImagePickerEvent(
      Union5<
              ImagePickerEventCleared,
              ImagePickerEventFileSelected,
              ImagePickerEventUploadStarted,
              ImagePickerEventUploadSuccess,
              ImagePickerEventUploadFailed>
          union)
      : super(union);

  factory ImagePickerEvent.cleared() =>
      ImagePickerEvent(_factory.first(ImagePickerEventCleared()));

  factory ImagePickerEvent.file(File file) =>
      ImagePickerEvent(_factory.second(ImagePickerEventFileSelected(file)));

  factory ImagePickerEvent.upload() =>
      ImagePickerEvent(_factory.third(ImagePickerEventUploadStarted()));

  factory ImagePickerEvent.success(String url) =>
      ImagePickerEvent(_factory.fourth(ImagePickerEventUploadSuccess(url)));

  factory ImagePickerEvent.failed(Object ex) =>
      ImagePickerEvent(_factory.fifth(ImagePickerEventUploadFailed(ex)));

  @override
  String toString() {
    return this.join(
        (_) => "ImagePickerEventCleared",
        (file) => "ImagePickerEventFileSelected(${file.file})",
        (file) => "ImagePickerEventUploadStarted()",
        (success) => "ImagePickerEventUploadSuccess(${success.url})",
        (error) => "ImagePickerEventUploadFailed(${error.ex})");
  }
}

class ImagePickerEventCleared {}

class ImagePickerEventFileSelected {
  final File file;

  ImagePickerEventFileSelected(this.file);
}

class ImagePickerEventUploadStarted {}

class ImagePickerEventUploadSuccess {
  final String url;

  ImagePickerEventUploadSuccess(this.url);
}

class ImagePickerEventUploadFailed {
  final Object ex;

  ImagePickerEventUploadFailed(this.ex);
}

class ImagePickerState extends Union6Impl<
    ImagePickerEmpty,
    ImagePickerFile,
    ImagePickerUrl,
    ImagePickerUploading,
    ImagePickerUploadSuccess,
    ImagePickerError> {
  static final _factory = Sextet<
      ImagePickerEmpty,
      ImagePickerFile,
      ImagePickerUrl,
      ImagePickerUploading,
      ImagePickerUploadSuccess,
      ImagePickerError>();

  ImagePickerState(
      Union6<ImagePickerEmpty, ImagePickerFile, ImagePickerUrl,
              ImagePickerUploading, ImagePickerUploadSuccess, ImagePickerError>
          union)
      : super(union);

  factory ImagePickerState.empty() =>
      ImagePickerState(_factory.first(ImagePickerEmpty()));

  factory ImagePickerState.file(File file) =>
      ImagePickerState(_factory.second(ImagePickerFile(file)));

  factory ImagePickerState.url(String url) =>
      ImagePickerState(_factory.third(ImagePickerUrl(url)));

  factory ImagePickerState.uploading(File file) =>
      ImagePickerState(_factory.fourth(ImagePickerUploading(file)));

  factory ImagePickerState.success(String url) =>
      ImagePickerState(_factory.fifth(ImagePickerUploadSuccess(url)));

  factory ImagePickerState.error(Object ex) =>
      ImagePickerState(_factory.sixth(ImagePickerError(ex)));

  @override
  String toString() {
    return this.join(
        (empty) => "ImagePickerEmpty",
        (file) => "ImagePickerFile(${file.file})",
        (url) => "ImagePickerUrl(${url.url})",
        (uploading) => "ImagePickerUploading(${uploading.file})",
        (success) => "ImagePickerUploadSuccess(${success.url})",
        (error) => "ImagePickerError(${error.ex})");
  }
}

class ImagePickerEmpty {}

class ImagePickerFile {
  final File file;

  ImagePickerFile(this.file);
}

class ImagePickerUrl {
  final String url;

  ImagePickerUrl(this.url);
}

class ImagePickerUploading {
  final File file;

  ImagePickerUploading(this.file);
}

class ImagePickerUploadSuccess {
  final String url;

  ImagePickerUploadSuccess(this.url);
}

class ImagePickerError {
  final Object ex;

  ImagePickerError(this.ex);
}
