import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/home/hoem_page.dart';
import 'package:flutter_demo/pages/me/me_page.dart';

void main() {
  runApp(MaterialApp(
    title: "谷歌翻译",
    home: GOBottomNavigationBar(),
  ));
}

final List<Widget> pages = [HomePage(),MePage()];

final List<BottomNavigationBarItem> items = [
  BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
  BottomNavigationBarItem(icon: Icon(Icons.people), label: "我的")
];

class GOBottomNavigationBar extends StatefulWidget {
  const GOBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<GOBottomNavigationBar> createState() => _GOBottomNavigationBarState();
}

class _GOBottomNavigationBarState extends State<GOBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: pages[_currentIndex],
      appBar: AppBar(title: Text("翻译"),),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: items,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
