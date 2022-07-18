import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class MyBatteryWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyBatteryWidgetState();
  }
}

class MyBatteryWidgetState extends State<MyBatteryWidget> {
  static const platform = MethodChannel('samples.flutter.dev/battery');

  String _batteryLevel = "Unknown battery level";

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = "Battery level : $result %";
    } on PlatformException catch (e) {
      batteryLevel = "fail ${e.message}";
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: _getBatteryLevel,
                child: const Text("Get Battery level")),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }
}
