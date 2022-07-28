import 'package:flutter/material.dart';
import 'package:my_flutter01/detail/detailinfo.dart';

import 'mybanner.dart';

final String imsg =
    "https://bkimg.cdn.bcebos.com/pic/7af40ad162d9f2d3ea2b4b92a6ec8a136327cc91?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto";

class MyHomeList extends StatefulWidget {
  const MyHomeList({Key? key}) : super(key: key);

  @override
  State<MyHomeList> createState() => _MyHomeListState();
}

class _MyHomeListState extends State<MyHomeList> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        return Future<void>.delayed(Duration(seconds: 3));
      },
      child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: 21,
          itemBuilder: (context, index) {
            if (index == 0) {
              return SizedBox(height: 200, child: MyBanner());
            } else {
              return MyListItem();
            }
          }),
    );
  }
}

class MyListItem extends StatefulWidget {
  const MyListItem({Key? key}) : super(key: key);

  @override
  State<MyListItem> createState() => _MyListItemState();
}

class _MyListItemState extends State<MyListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.orange[100],
        child: Column(
          children: [
            headItem(),
            GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return detailinfoWidget();
                  }));
                },
                child: MyBannerImage(
                    "https://bkimg.cdn.bcebos.com/pic/7af40ad162d9f2d3ea2b4b92a6ec8a136327cc91?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto")),
            bottomItem(),
          ],
        ),
      ),
    );
  }
}

Widget headItem() => Row(
      children: [
        ClipRRect(
          child: Image.asset(width: 30, height: 30, "images/img.png"),
        ),
        Text("My name"),
        Row(
          children: [Icon(Icons.menu_book), Icon(Icons.menu_open)],
        ),
        Expanded(child: Container()),
        TextButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                side: BorderSide(color: Colors.green, width: 1)),
            child: Row(
              children: [Icon(Icons.add), Text("add")],
            )),
      ],
    );

Widget bottomItem() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("This title"),
        Row(
          children: [
            Expanded(
                child: Text("${DateTime.now().toString().substring(0, 19)}")),
            Row(
              children: [Text("detail"), Icon(Icons.arrow_right)],
            )
          ],
        )
      ],
    );
