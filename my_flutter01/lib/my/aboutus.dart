import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutUsWidget extends StatefulWidget {
  const AboutUsWidget({Key? key}) : super(key: key);

  @override
  State<AboutUsWidget> createState() => _AboutUsWidgetState();
}

class _AboutUsWidgetState extends State<AboutUsWidget> {
  late Future<AndroidDeviceInfo> androidInfo;
  late Future<PackageInfo> packageInfo;

  Future<void> getDevice() async {
    DeviceInfoPlugin info = DeviceInfoPlugin();
    androidInfo = info.androidInfo;
    packageInfo = PackageInfo.fromPlatform();
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Text("Flutter function and widget learn through"),
            TextButton(
                onPressed: () {
                  showAboutDialog(context: context, children: [
                    Text("Version : 1.0"),
                  ]);
                },
                child: Text("about us")),
            FutureBuilder<AndroidDeviceInfo>(
                future: androidInfo,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        ListTile(
                          title:
                              Text(snapshot.data?.manufacturer ?? "not found"),
                          subtitle: Text("manufacturer"),
                        ),
                        ListTile(
                          title: Text("${snapshot.data?.version.toMap()}"),
                          subtitle: Text("version"),
                        ),
                        ListTile(
                          title: Text(snapshot.data?.model ?? "not found"),
                          subtitle: Text("model"),
                        ),
                        ListTile(
                          title: Text(snapshot.data?.product ?? "not found"),
                          subtitle: Text("product"),
                        ),
                        ListTile(
                          title: Text(snapshot.data?.androidId ?? "not found"),
                          subtitle: Text("androidId"),
                        ),
                        ListTile(
                          title: Text(snapshot.data?.board ?? "not found"),
                          subtitle: Text("board"),
                        ),
                        ListTile(
                          title: Text(snapshot.data?.brand ?? "not found"),
                          subtitle: Text("brand"),
                        ),
                        ListTile(
                          title: Text(snapshot.data?.device ?? "not found"),
                          subtitle: Text("device"),
                        ),
                        ListTile(
                          title: Text(snapshot.data?.display ?? "not found"),
                          subtitle: Text("display"),
                        ),
                        ListTile(
                          title:
                              Text(snapshot.data?.fingerprint ?? "not found"),
                          subtitle: Text("fingerprint"),
                        ),
                        ListTile(
                          title: Text(snapshot.data?.hardware ?? "not found"),
                          subtitle: Text("hardware"),
                        ),
                        ListTile(
                          title: Text(snapshot.data?.host ?? "not found"),
                          subtitle: Text("host"),
                        ),
                        ListTile(
                          title: Text(snapshot.data?.tags ?? "not found"),
                          subtitle: Text("tags"),
                        ),
                        ListTile(
                          title: Text(snapshot.data?.type ?? "not found"),
                          subtitle: Text("type"),
                        ),
                        ListTile(
                          title: Text("${snapshot.data?.isPhysicalDevice}"),
                          subtitle: Text("isPhysicalDevice"),
                        ),
                        ListTile(
                          title: Text(snapshot.data?.id ?? "not found"),
                          subtitle: Text("id"),
                        ),
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            Divider(
              height: 5,
              color: Colors.blue,
            ),
            FutureBuilder<PackageInfo>(
                future: packageInfo,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text("${snapshot.data?.appName}"),
                          subtitle: Text("appname"),
                        ),
                        ListTile(
                          title: Text("${snapshot.data?.version}"),
                          subtitle: Text("version"),
                        ),
                        ListTile(
                          title: Text("${snapshot.data?.buildNumber}"),
                          subtitle: Text("buildnumber"),
                        ),
                        ListTile(
                          title: Text("${snapshot.data?.buildSignature}"),
                          subtitle: Text("buildsignature"),
                        ),
                        ListTile(
                          title: Text("${snapshot.data?.packageName}"),
                          subtitle: Text("packagename"),
                        )
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
