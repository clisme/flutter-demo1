import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart'; // 添加这行导入
import 'package:flutter_application_1/HomePage.dart';
import 'package:flutter_application_1/routes.dart';
// void main() {
//   final router = FluroRouter();
//   Routes.configureRoutes(router);
//   runApp(MyApp(router));
// }

// 应用入口配置
void main() {
  final router = FluroRouter();
  Routes.configureRoutes(router);

  runApp(
    AppTheme(
      appBar: AppBar(
        title: const Text('全局导航栏123'),
        backgroundColor: Colors.deepPurple,
      ),
      child: ChangeNotifierProvider(
        create: (_) => UserStatusProvider(),
        child: MyApp(router),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final FluroRouter router;

  MyApp(this.router);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluro Demo',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generator,
      home: HomePage(router: router),
    );
  }
}

// class SecondPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Second Page'),
//       ),
//       body: Center(
//         child: Text('This is the second page'),
//       ),
//     );
//   }
// }

// class ProfileScreen extends StatelessWidget {
//   final String? id;

//   ProfileScreen({this.id});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile Screen'),
//       ),
//       body: Center(
//         child: Text('Profile ID: $id'),
//       ),
//     );
//   }
// }

// 定义全局组件库
class GlobalWidgets {
  // 统一文本按钮
  static Widget textButton(String text, VoidCallback onPressed) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }

  // 统一卡片样式
  static Widget card({required Widget child}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: child,
      ),
    );
  }
}

// 继承组件定义
class AppTheme extends InheritedWidget {
  final Widget appBar;

  const AppTheme({
    required this.appBar,
    required super.child,
  });

  // 这段代码是 Flutter 中 InheritedWidget 的典型用法，用于在组件树中高效地共享数据。通过 of 方法，可以方便地获取上层组件提供的共享数据。
  static AppTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppTheme>();
  }

  @override
  bool updateShouldNotify(AppTheme oldWidget) => appBar != oldWidget.appBar;
}

// 状态管理类
class UserStatusProvider extends ChangeNotifier {
  Widget _statusWidget = const Text('未登录');

  Widget get statusWidget => _statusWidget;

  void login() {
    _statusWidget = const Text('已登录: user@example.com');
    notifyListeners();
  }

  void logout() {
    _statusWidget = const Text('未登录');
    notifyListeners();
  }
}

// 全局 Key 定义
final GlobalKey<FormState> globalFormKey = GlobalKey();

// 表单组件
class GlobalForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalFormKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: '用户名'),
            validator: (v) => v!.isEmpty ? '必填' : null,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: '密码'),
            obscureText: true,
            validator: (v) => v!.length < 6 ? '至少6位' : null,
          ),
        ],
      ),
    );
  }
}
