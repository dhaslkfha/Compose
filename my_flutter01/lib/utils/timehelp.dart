import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

Widget DataPicker(BuildContext context, Function(DateTime dateTime) callback) =>
    Container(
      height: 500,
      padding: EdgeInsets.only(top: 10),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(onPressed: () {}, child: Text("cancel")),
              Text(
                "Date Picker",
                style: TextStyle(fontSize: 20),
              ),
              TextButton(onPressed: () {}, child: Text("Confirm"))
            ],
          ),
          SafeArea(
            top: false,
            child: CupertinoDatePicker(
              onDateTimeChanged: (date) {
                callback(date);
              },
              mode: CupertinoDatePickerMode.date,
            ),
          ),
        ],
      ),
    );

void showMyDatePicker(
    BuildContext context, Function(DateTime dateTime) callback) {
  showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return DataPicker(context, (dateTime) => callback);
      });
}
