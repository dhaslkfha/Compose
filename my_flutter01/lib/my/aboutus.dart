import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class AboutUsWidget extends StatefulWidget {
  const AboutUsWidget({Key? key}) : super(key: key);

  @override
  State<AboutUsWidget> createState() => _AboutUsWidgetState();
}

class _AboutUsWidgetState extends State<AboutUsWidget> {
  late Future<AndroidDeviceInfo> androidInfo;

  Future<void> getDevice() async {
    DeviceInfoPlugin info = DeviceInfoPlugin();
    androidInfo = info.androidInfo;
  }

  @override
  void initState() {
    super.initState();
    getDevice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About us"),
      ),
      body: Column(
        children: [
          Text("Flutter function and widget learn through"),
          TextButton(onPressed: () {
            showAboutDialog(context: context,children: [
              Text("Version : 1.0"),
            ]);
          }, child: Text("about us")),
          FutureBuilder<AndroidDeviceInfo>(
              future: androidInfo,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListTile(
                    title: Text(snapshot.data?.manufacturer ?? "not found"),
                    subtitle: Text("manufacturer"),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ],
      ),
    );
  }
}
