
import 'package:flutter/material.dart';
import 'package:flutter_game_sdk/position_page.dart';

// flutter的命名规范
// 1.项目名：每个字母都小写...flutter_donew
// 2.文件名：每个字母都小写...app_page
// 3.类名：每个单词的首字母均大写...AppPage
class AppPage extends StatefulWidget {

  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() {
    return _AppPageState();
  }
}

class _AppPageState extends State<AppPage> {

  int _selectedIndex = 0;

  int? a;

  @override
  Widget build(BuildContext context) {
    // 第二步：第二个page将数据回传（需要先定义数据）
    // Navigator.of(context).pop(widget.appName);

    // 脚手架
    // 每个App的页面最外层都有一个Scaffold()
    // 此页面是App的容器页面：只有一个
    return Scaffold(
      // 正文页面
      // https://www.jianshu.com/p/387d730cbe92
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          PositionPage(),
          PositionPage(),
          PositionPage(),
          PositionPage()
        ]
      ),
      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        // 当前选中index
        currentIndex: _selectedIndex,
        // 底部导航栏的样式
        // BottomNavigationBarType.fixed
        // BottomNavigationBarType.shifting
        type: BottomNavigationBarType.fixed,
        // 颜色表示方式
        // 1.ARGB - Color.fromARGB(a, r, g, b)...alpha表示不透明度：FF表示不透明，00表示透明
        // 2.RGBO - Color.fromRGBO(r, g, b, opacity)...opacity表示不透明度：1.0表示不透明，0.0表示透明
        // 3.固定写死 - Colors.red
        selectedItemColor: const Color.fromRGBO(0, 215, 198, 1.0), // 等同于Color.fromARGB(215, 0, 215, 198)
        unselectedItemColor: Colors.grey,
        // 字体大小可以不变
        selectedFontSize: 11.0,
        unselectedFontSize: 11.0,
        // 分栏
        items: [
          BottomNavigationBarItem(
            // 普通icon
            icon: Image.asset(
              'assets/bottom_navigation_bar/tab_position_normal.png',
              width: 30,
              height: 24,
            ),
            // 选中icon
            activeIcon: Image.asset(
              'assets/bottom_navigation_bar/tab_position_active.png',
              width: 30,
              height: 24,
            ),
            // 背景颜色
            backgroundColor: Colors.white,
            // 文字
            label: "职位"
          ),
          BottomNavigationBarItem(
            // 普通icon
              icon: Image.asset(
                'assets/bottom_navigation_bar/tab_position_normal.png',
                width: 30,
                height: 24,
              ),
              // 选中icon
              activeIcon: Image.asset(
                'assets/bottom_navigation_bar/tab_position_active.png',
                width: 30,
                height: 24,
              ),
              // 背景颜色
              backgroundColor: Colors.white,
              // 文字
              label: "职位"
          ),
          BottomNavigationBarItem(
            // 普通icon
              icon: Image.asset(
                'assets/bottom_navigation_bar/tab_position_normal.png',
                width: 30,
                height: 24,
              ),
              // 选中icon
              activeIcon: Image.asset(
                'assets/bottom_navigation_bar/tab_position_active.png',
                width: 30,
                height: 24,
              ),
              // 背景颜色
              backgroundColor: Colors.white,
              // 文字
              label: "职位"
          ),
          BottomNavigationBarItem(
              // 普通icon
              icon: Image.asset(
                'assets/bottom_navigation_bar/tab_position_normal.png',
                width: 30,
                height: 24,
              ),
              // 选中icon
              activeIcon: Image.asset(
                'assets/bottom_navigation_bar/tab_position_active.png',
                width: 30,
                height: 24,
              ),
              // 背景颜色
              backgroundColor: Colors.white,
              // 文字
              label: "职位"
          )
        ],
        // 点击item回调
        onTap: (index) {
          // 原理：通知flutter框架状态发生改变，flutter框架在收到消息后，会调用build方法重新构建widget树，从而达到更新UI的目的
          // 修改_selectedIndex并重绘
          // 只有statefulWidget里面才有该方法
          // 变量改变以后必须调用该方法才能修改界面
          // _selectedIndex = index; // 可以放在这里
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}