import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

Widget DataPicker(BuildContext context, Function(DateTime dateTime) callback) {
  DateTime? time;
  return Container(
    height: 300,
    padding: EdgeInsets.only(top: 10),
    margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    color: CupertinoColors.systemBackground.resolveFrom(context),
    child: SafeArea(
      top: false,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (time != null) {
                      callback(time!);
                    }
                  },
                  child: Text("cancel")),
              TextButton(
                onPressed: () {},
                child: Text("Date Picker"),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Confirm"))
            ],
          ),
          Flexible(
            child: CupertinoDatePicker(
              initialDateTime: DateTime.now(),
              use24hFormat: true,
              onDateTimeChanged: (date) {
                time = date;
                callback(date);
              },
              mode: CupertinoDatePickerMode.date,
            ),
          ),
        ],
      ),
    ),
  );
}

void showMyDatePicker(
    BuildContext context, Function(DateTime dateTime) callback) {
  showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return DataPicker(context, (dateTime) => callback);
      });
}
