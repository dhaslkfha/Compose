import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter01/base/mconstant.dart';

class HobbyWidget extends StatefulWidget {
  const HobbyWidget({Key? key}) : super(key: key);

  @override
  State<HobbyWidget> createState() => _HobbyWidgetState();
}

class _HobbyWidgetState extends State<HobbyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bobby"),
        actions: [IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.save_as)),
        ],
      ),
      body: ListView.builder(
        itemCount: 20,
          itemBuilder: (context, index) => Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        Image.network(
                          imgUrl,
                          width: 60,
                          height: 40,
                        ),
                        Text("Relax")
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 5,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text("hobby1"),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.cyan[100]),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("hobby2"),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.cyan[100]),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("hobby3"),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.cyan[100]),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("hobby4"),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.cyan[100]),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("hobby5"),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.cyan[100]),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("hobby6"),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.cyan[100]),
                        ),
                      ],
                    ),
                  )
                ],
              )),
    );
  }
}
