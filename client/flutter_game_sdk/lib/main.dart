import 'package:flutter/material.dart';
import 'package:flutter_game_sdk/app_page.dart';
import 'package:flutter_game_sdk/color_utils.dart';

// dart支持顶层函数（java不支持顶层函数，所有的函数都必须位于class中）
// 如果一个函数中只有一条语句可以这样写
void main() => runApp(const MyApp());
// void main() {
//   runApp(const MyApp());
// }

// flutter中一切皆Widget
// StatelessWidget - 适用于当我们描述的用户界面不依赖于对象中的配置信息/死控件/不会随数据动态改变/无状态
// StatefulWidget - 动态更新UI/具有state对象存储状态数据并将其传递到树重建中/活控件/会随数据动态改变/有状态
// 命令式UI - 手动构建全功能UI实体，然后在UI更改时使用方法对其进行变更/在旧的上进行修改
// 声明式UI - widget会在自身上触发重建并构建一个新的widget子树/生成新的
// widget具有不同性 - 每当widget状态发生改变的时候就会创建一个新的widget
// https://www.jianshu.com/p/88c66747eec1
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // App的root widget
  @override
  Widget build(BuildContext context) {
    // 每个App的最外层都有一个MaterialApp()
    return MaterialApp(
      title: 'flutter笔记',
      // 关闭debug
      debugShowCheckedModeBanner: false,
      // App主题
      theme: ThemeData(
        // 主色：决定导航栏颜色
        primarySwatch: ColorUtils().createMaterialColor(const Color.fromRGBO(0, 215, 198, 1.0)),
      ),
      // // 第一步：注册page（无法传递参数）
      // routes: {
      //   '/app': (context) => const AppPage(),
      //   '/home': (context) => const HomePage()
      // },
      // 指定首页page
      home: const AppPage(),
    );
  }
}

/*
// 延迟执行
Future.delayed(const Duration(seconds: 2), () async {
  // 第三步：第一个Page等待数据回传（await此处代码会暂停执行等待回传）
  // 路由跳转
  final result = await Navigator.of(context).push(
    // 第一步：在第一个page中将数据传入第二个page
    // 传入数据到下一个页面
    MaterialPageRoute(builder: (context) => const AppPage(appName: 'flutter_shop'))
  );
  print('appName is $result');
});

// 延迟执行
Future.delayed(const Duration(seconds: 2), () {
  // 跳转
  // Navigator.of(context, rootNavigator: true); // 如果有多个Navigator
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => const AppPage())
  );
  // 跳转到指定路由
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => const AppPage()), (route) => false);
  // // 第二步（无法传递参数）
  // Navigator.of(context).pushNamed('/app');
  // 替换路由（保证始终只有一个路由）
  Navigator.of(context).pushReplacementNamed('/app');
});
*/

/*
// StatelessWidget
// 1>.创建组件
class HomePage extends StatelessWidget {
  // 2>.定义构造方法
  // 第一种写法
  const HomePage({Key? key}) : super(key: key);
  final String name = '';
  // 第二种写法
  const HomePage({Key? key, required this.name}) : super(key: key);
  final String name;
  // 第三种写法
  const HomePage({Key? key, this.name}) : super(key: key);
  final String? name;
  
  // 3>.重写方法
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text(widget.name),
    );
  }
}
// StatefulWidget
// 1>.创建组件
class HomePage extends StatefulWidget {
  // 2>.定义构造方法
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() {
    return _HomeState();
  }
}
// 3.创建state
class _HomeState extends State<HomePage> {
  // 第一种情况
  int _selectedIndex = 0;
  // 第二种情况
  int? _selectedIndex;
  // 第三种情况
  late int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text(''),
    );
  }
}
*/