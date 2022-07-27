import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter01/home/hometab.dart';
import 'package:path/path.dart';
import 'homelist.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'mybanner.dart';

///首页
class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  List<Widget> widgetList = [
    Column(
      children: [
        homeTopWidget(),
        Expanded(child: MyHomeList()),
      ],
    ),
    Column(
      children: [
        Expanded(
          child: WebView(
            initialUrl: "https://flutter.dev",
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
        Expanded(child: const Center(child: Text("第二个界面"))),
        MyBannerImage(
            "https://bkimg.cdn.bcebos.com/pic/7af40ad162d9f2d3ea2b4b92a6ec8a136327cc91?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto")
      ],
    ),
  ];
  int _selected = 0;

  void _onTapNav(int index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(index: _selected, children: widgetList),
          ),
          BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: "我的"),
            ],
            selectedItemColor: Colors.amber[500],
            type: BottomNavigationBarType.fixed,
            onTap: _onTapNav,
            currentIndex: _selected,
          ),
        ],
      ),
    );
  }
}

class homeTopWidget extends StatefulWidget {
  const homeTopWidget({Key? key}) : super(key: key);

  @override
  State<homeTopWidget> createState() => _homeTopWidgetState();
}

class _homeTopWidgetState extends State<homeTopWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: SizedBox(
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 0, color: Colors.grey)),
                      hintText: "请输入关键字搜索",
                      prefixIcon: Icon(Icons.search_rounded),
                      isCollapsed: false,
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    textCapitalization: TextCapitalization.characters,
                    onSubmitted: (input) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("输入提示"),
                              content: Text("你输入了 $input"),
                              actions: [
                                TextButton(
                                  child: Text("确定"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          });
                    },
                  ),
                )),
            Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(10.0),
                child: Stack(children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){return homeTab();}));
                    },
                    child: Container(),
                    style: OutlinedButton.styleFrom(
                        fixedSize: Size(30, 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        side: BorderSide(color: Colors.black, width: 2)),
                  ),
                  Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ])),
          ],
        ),
      ),
    );
  }
}
