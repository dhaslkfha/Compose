import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:webview_flutter/webview_flutter.dart';

///首页
class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  List<Widget> widgetList = [
    Column(
      children: const [
        homeTopWidget(),
        Expanded(
          child: WebView(
            initialUrl: "https://flutter.dev",
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ],
    ),
    Column(
      children: [
        SizedBox(height: 200, child: MyBanner()),
        Expanded(child: const Center(child: Text("第二个界面"))),
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
                )),
            SizedBox(
                height: 50,
                width: 50,
                child: OutlinedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      side: BorderSide(color: Colors.black, width: 2)),
                )),
          ],
        ),
      ),
    );
  }
}

class MyBanner extends StatefulWidget {
  const MyBanner({Key? key}) : super(key: key);

  @override
  State<MyBanner> createState() => _MyBannerState();
}

class _MyBannerState extends State<MyBanner> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        Image.network(
            "https://bkimg.cdn.bcebos.com/pic/7af40ad162d9f2d3ea2b4b92a6ec8a136327cc91?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto"),
        Image.network(
            "https://bkimg.cdn.bcebos.com/pic/7af40ad162d9f2d3ea2b4b92a6ec8a136327cc91?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto"),
        Image.network(
            "https://bkimg.cdn.bcebos.com/pic/7af40ad162d9f2d3ea2b4b92a6ec8a136327cc91?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto"),
        Image.network(
            "https://bkimg.cdn.bcebos.com/pic/7af40ad162d9f2d3ea2b4b92a6ec8a136327cc91?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto"),
        Image.network(
            "https://bkimg.cdn.bcebos.com/pic/7af40ad162d9f2d3ea2b4b92a6ec8a136327cc91?x-bce-process=image/watermark,image_d2F0ZXIvYmFpa2UxNTA=,g_7,xp_5,yp_5/format,f_auto"),
      ],
    );
  }
}
