import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../home/mybanner.dart';

class detailinfoWidget extends StatefulWidget {
  const detailinfoWidget({Key? key}) : super(key: key);

  @override
  State<detailinfoWidget> createState() => _detailinfoWidgetState();
}

class _detailinfoWidgetState extends State<detailinfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
          child: Column(
        children: [
          Hero(
            tag: "item",
            child: MyBannerImage(
                "https://bkimg.cdn.bcebos.com/pic/7af40ad162d9f2d3ea2b4b92a6ec8a136327cc91?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto"),
          ),
          Expanded(
            child: WebView(
              initialUrl: "https://flutter.dev",
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ],
      )),
    );
  }
}
