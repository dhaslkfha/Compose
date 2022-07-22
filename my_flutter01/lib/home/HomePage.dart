import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    const Center(child: Text("第二个界面")),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(color: Colors.grey,width: 1)
                  ),
                  labelText: "",
                  hintText: "请输入关键字搜索",
                helperText: "",
                prefixIcon: Icon(Icons.search_rounded),
                
              ),
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
          OutlinedButton(onPressed: () {}, child: Icon(Icons.add))
        ],
      ),
    );
  }
}
