import 'dart:io';
import 'package:card_settings/card_settings.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_politburo/ui/component/image_picker.dart';
import 'package:quiver/core.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';

class CardSettingsPhotoPicker extends FormField<List<File>> {
  static final imageEditingControllers = <ImagePickerEditingController>[];

  CardSettingsPhotoPicker({
    Key key,
    String label: 'Label',
    TextAlign labelAlign,
    TextAlign contentAlign,
    Icon icon,
    Widget requiredIndicator,
    String trueLabel: 'Yes',
    String falseLabel: 'No',
    List<File> initialValue: const <File>[],
    bool autovalidate: false,
    bool visible: true,
    FormFieldSetter<List<File>> onSaved,
    FormFieldValidator<List<File>> validator,
    ValueChanged<List<File>> onChanged,
    ImageUploader uploader,
  }) : super(
            key: key,
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<List<File>> field) {
              Fimber.d("Building image picker card");
              final _CardSettingsPhotoPickerState state = field;
              Fimber.d("State [${state.value}]");

              var imagePickers = mutableListOf<ImagePicker>();
              for(var i = 0; i < state.value.length; i++) {
                final controller = ImagePickerEditingController(Optional.of(state.value[i]));
                imageEditingControllers.add(controller);
                imagePickers.add(ImagePicker(controller, uploader));
                controller.addListener(() => _onImageSelect(controller, state, i));
              }
              final controller = ImagePickerEditingController(Optional.absent());
              imageEditingControllers.add(controller);
              imagePickers.add(ImagePicker(controller, uploader));
              controller.addListener(() => _onImageSelect(controller, state, state.value.length));

              Fimber.d("Pickers [$imagePickers]");
              final rows = imagePickers.chunked(2).map((pickers) => Row(children: pickers.list,)).list;

              Fimber.d("Rows [$rows]");
              return CardSettingsField(
                  label: label,
                  labelAlign: labelAlign,
                  visible: visible,
                  icon: icon,
                  requiredIndicator: requiredIndicator,
                  errorText: field.errorText,
//                  content: Column(children: rows,)
                  content: GridView.extent(maxCrossAxisExtent: 172, children: imagePickers.list, shrinkWrap: true, physics: NeverScrollableScrollPhysics(),),
              );
            });

  static _onImageSelect(ImagePickerEditingController controller, FormFieldState<List<File>> state, int index) {
    Fimber.d("ImagePickerEditingController returned new value ${controller.value}");
    Fimber.d("State [${state.value}]");
    if (controller.value.file.isPresent) {
      var list = state.value.toList(growable: true);
      list.insert(index, controller.image.value);
//      state.didChange(state.value.followedBy([controller.image.value]).toList());
      state.didChange(list);
    } else {
      var list = state.value.toList(growable: true);
      list.removeAt(index);
      state.didChange(list);
    }
  }

  static Future<String> _upload(File file) async {
    return "";
  }

  @override
  FormFieldState<List<File>> createState() => _CardSettingsPhotoPickerState();
}

class _CardSettingsPhotoPickerState extends FormFieldState<List<File>> {
  final list = <File>[];

  @override
  void initState() {
    super.initState();
    setValue(list);
  }


}



/*
class CardSettingsPhotoPicker extends FormField<File> {
  CardSettingsPhotoPicker({
    Key key,
    String label: 'Label',
    TextAlign labelAlign,
    TextAlign contentAlign,
    Icon icon,
    Widget requiredIndicator,
    String trueLabel: 'Yes',
    String falseLabel: 'No',
    File initialValue,
    bool autovalidate: false,
    bool visible: true,
    FormFieldSetter<File> onSaved,
    FormFieldValidator<File> validator,
    ValueChanged<File> onChanged,
  }) : super(
            key: key,
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<File> field) {
              final _CardSettingsPhotoPickerState state = field;
              return CardSettingsField(
                  label: label,
                  labelAlign: labelAlign,
                  visible: visible,
                  icon: icon,
                  requiredIndicator: requiredIndicator,
                  errorText: field.errorText,
                  content: Stack(
                    fit: StackFit.loose,
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: 72, maxWidth: 72),
                        child: state.value != null
                            ? Image.file(
                                state.value,
                              )
                            : BoxDecoration(color: Colors.black12),
                      ),
                      Icon(Icons.add)
                    ],
                  ));
            });

  @override
  FormFieldState<File> createState() => _CardSettingsPhotoPickerState();
}
 */
