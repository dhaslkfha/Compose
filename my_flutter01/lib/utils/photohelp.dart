import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

Widget photoChooseDialog(BuildContext context) => CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
            onPressed: () {
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

Future<void> showPhotoChooseDialog(BuildContext context) async {
  var result = showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return photoChooseDialog(context);
      });
  if (result == "camera") {
    showcamera(context);
  } else if (result == "gallery") {
    var file = choseAImage();
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

Future<String> choseAImage() async {
  final imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
  var path = file?.path ?? "";
  return path;
}
