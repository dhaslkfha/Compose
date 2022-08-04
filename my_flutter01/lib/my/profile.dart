import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/photohelp.dart';
import '../utils/timehelp.dart';
import 'hobby.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<PItemBean> lists = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lists.add(PItemBean(
        "Head",
        "content",
        "https://img.uni.changan.com.cn/base/2022/06/17/1655432716860androidios1920_864.jpeg",
        false,
        false,
        1));
    lists.add(PItemBean("Nick Name", "My Name is Tom", "", true, false, 2));
    lists
        .add(PItemBean("Signature", "Help me help myself", "", false, true, 3));
    lists.add(PItemBean("Sex", "Male", "", true, true, 4));
    lists.add(PItemBean("Birthday", "1990-2-2", "", true, true, 5));
    lists.add(PItemBean("Star", "-", "", false, false, 6));
    lists.add(PItemBean("Hobby", "Football", "", false, true, 7));
    lists.add(PItemBean("Email", "39939@163.com", "", false, true, 8));
    lists.add(PItemBean("Address", "Beijing", "", false, true, 9));
    lists.add(PItemBean("Industry", "IT", "", false, true, 10));
    lists.add(PItemBean("Sign in Time", "2020-6-6", "", false, false, 11));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: lists.map((e) => ProfileItem(e)).toList(),
        ),
      ),
    );
  }
}

class ProfileItem extends StatefulWidget {
  ProfileItem(
    this.bean, {
    Key? key,
  }) : super(key: key);
  final PItemBean bean;

  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                if (widget.bean.type == 1) {
                  showPhotoChooseDialog(context, (path) {
                    setState(() {
                      widget.bean.img = path;
                    });
                  });
                } else if (widget.bean.type == 5) {
                  showMyDatePicker(context, (datetime) {
                    setState(() {
                      widget.bean.content =
                          "${datetime.year}-${datetime.month}-${datetime.day}";
                    });
                  });
                } else if (widget.bean.type == 7) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return HobbyWidget();
                  }));
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("not fulfill")));
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${widget.bean.name}",
                    style: TextStyle(fontSize: 16),
                  ),
                  Visibility(
                      visible: widget.bean.isMust,
                      child: Text(
                        "*",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      )),
                  Visibility(
                      visible: widget.bean.img.isEmpty,
                      child: Expanded(
                          child: Text(
                        "${widget.bean.content}",
                        textAlign: TextAlign.right,
                      ))),
                  Visibility(
                      visible: widget.bean.img.isNotEmpty &&
                          widget.bean.img.startsWith("http"),
                      child: Expanded(
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: ClipOval(
                                child: Image.network(
                              widget.bean.img,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ))),
                      )),
                  Visibility(
                      visible: widget.bean.img.isNotEmpty &&
                          !widget.bean.img.startsWith("http"),
                      child: Expanded(
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: ClipOval(
                                child: Image.file(
                              File(widget.bean.img),
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ))),
                      )),
                  Visibility(
                    visible: widget.bean.isRight,
                    child: Icon(
                      Icons.chevron_right,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 10,
              thickness: 1,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}

class PItemBean {
  String name = "";
  String content = "";
  String img = "";
  bool isMust = false;
  bool isRight = false;
  int type = 0;

  PItemBean(
      this.name, this.content, this.img, this.isMust, this.isRight, this.type);
}
