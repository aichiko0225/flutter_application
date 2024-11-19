import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//ListView 内部组合了 Scrollable、Viewport 和 Sliver，需要注意：
//
// ListView 中的列表项组件都是 RenderBox，并不是 Sliver， 这个一定要注意。
// 一个 ListView 中只有一个Sliver，对列表项进行按需加载的逻辑是 Sliver 中实现的。
// ListView 的 Sliver 默认是 SliverList，如果指定了 itemExtent ，则会使用 SliverFixedExtentList；
// 如果 prototypeItem 属性不为空，则会使用 SliverPrototypeExtentList，无论是是哪个，都实现了子组件的按需加载模型。

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ListState();
  }
}

class _ListState extends State<ListPage> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ListPage'),
        ),
        body: Column(children: [
          Expanded(
              child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: <Widget>[
              const Text('I\'m dedicating every day to you'),
              const Text('Domestic life was never quite my style'),
              const Text('When you smile, you knock me out, I fall apart'),
              const Text('And I thought I was so smart'),
            ],
          )),
          Expanded(
              child: ListView.builder(
                  itemCount: 100,
                  itemExtent: 50.0, //列表项高度固定时，显式指定高度是一个好习惯(性能消耗小)
                  controller: _controller,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("$index"),
                    );
                  }))
        ]));
  }
}
