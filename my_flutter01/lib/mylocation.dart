import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_flutter01/battery.dart';

class MyLocationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyLocationWidgetState();
}

class MyLocationWidgetState extends State<MyLocationWidget> {
  late Position? _position;
  String location = "initail";

  void getPosition() async {
    WidgetsFlutterBinding.ensureInitialized();
    _position = await _determinePosition();

    print(1);
    setState(() {
      location = "经度:${_position?.longitude},纬度：${_position?.latitude}";
      print(location);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("地图服务"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(location),
            ElevatedButton(
                onPressed: (){
                  print(0);
                  getPosition();
                },
                child: Text("获取经纬度")),
          ],
        ),
      ),
    );
  }
}

Future<Position?> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  print(serviceEnabled);
  if (!serviceEnabled) {
    return Future.error("Location service are disable");
  }

  permission = await Geolocator.checkPermission();
  print(permission);

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error("Location permissions are denied");
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error("Location permissions are permanently denied");
  }

  print(-1);
  return await Geolocator.getLastKnownPosition();
}
class MySimpleGreat extends StatefulWidget {
  const MySimpleGreat({Key? key}) : super(key: key);

  @override
  State<MySimpleGreat> createState() => _MySimpleGreatState();
}

class _MySimpleGreatState extends State<MySimpleGreat> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyAnimationss extends StatefulWidget {
  const MyAnimationss({Key? key}) : super(key: key);

  @override
  State<MyAnimationss> createState() => _MyAnimationssState();
}

class _MyAnimationssState extends State<MyAnimationss> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
