import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

Widget photoChooseDialog(BuildContext context) => CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
            onPressed: () {
              print("image_picker: pop_camera");
              Navigator.of(context).pop("camera");
            },
            child: Text("Take a photo")),
        CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop("gallery");
            },
            child: Text("Choose from Gallery")),
      ],
      cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop("cancel");
          },
          child: Text("Cancel")),
    );

Future<void> showPhotoChooseDialog(BuildContext context,  Function(dynamic path) callback) async {
  var result = await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return photoChooseDialog(context);
      });
  print("image_picker: result = $result");
  if (result == "camera") {
    print("image_picker:camera");
    final imagePicker = ImagePicker();
    var file = choseAImage(ImageSource.camera, imagePicker);

    callback(file);
    // showcamera(context);
  } else if (result == "gallery") {
    print("image_picker:gallery");
    final imagePicker = ImagePicker();
    var file = choseAImage(ImageSource.gallery, imagePicker);
    callback(file);
  } else {}
}

late CameraDescription cameraDescription;

Future<void> showcamera(BuildContext context) async {
  // WidgetsFlutterBinding.ensureInitialized();
  final camera = await availableCameras();
  cameraDescription = camera[0];
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return TakeAPhoto();
  }));
}

class TakeAPhoto extends StatefulWidget {
  const TakeAPhoto({Key? key}) : super(key: key);

  @override
  State<TakeAPhoto> createState() => _TakeAPhotoState();
}

class _TakeAPhotoState extends State<TakeAPhoto> {
  late CameraController _controller;
  late Future<void> _controllerinitial;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CameraController(cameraDescription, ResolutionPreset.medium);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Take a photo"),
      ),
      body: FutureBuilder<void>(
        future: _controllerinitial,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.takePicture();
        },
        child: Icon(Icons.camera_alt_outlined),
      ),
    );
  }
}

///
/// chose from gallery

Future<String> choseAImage(ImageSource source, ImagePicker imagePicker) async {
  print("image_picker:choseAImage");
  XFile? file = await imagePicker.pickImage(source: source);
  var path = file?.path ?? "";
  print("image_picker:path = $path");
  return path;
}
