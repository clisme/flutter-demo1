// import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:provider/provider.dart';

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.141592653589793)
        .animate(_controller);
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.5).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(1, 0))
        .animate(_controller);
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 全局验证方法
  void validateGlobalForm() {
    // debugger();
    if (globalFormKey.currentState?.validate() ?? false) {
      print('表单验证通过');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 使用示例
            // GlobalWidgets.textButton('提交', () => print('Clicked')),
            GlobalForm(),
            // 使用示例
            ElevatedButton(
              onPressed: validateGlobalForm,
              child: const Text('提交'),
            ),
            ProfilePage(),
            GlobalWidgets.card(child: Text('全局卡片')),
            RotationTransition(
              turns: _rotationAnimation,
              child: Icon(Icons.refresh, size: 50),
            ),
            SizedBox(height: 20),
            ScaleTransition(
              scale: _scaleAnimation,
              child: Icon(Icons.zoom_out_map, size: 50),
            ),
            SizedBox(height: 20),
            SlideTransition(
              position: _slideAnimation,
              child: Icon(Icons.slideshow, size: 50),
            ),
            SizedBox(height: 20),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Icon(Icons.refresh, size: 50),
            ),
          ],
        ),
      ),
    );
  }
}

// 任意子组件中使用
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final status = context.watch<UserStatusProvider>().statusWidget;
    return Column(
      children: [
        status,
        ElevatedButton(
          onPressed: () => context.read<UserStatusProvider>().login(),
          child: const Text('登录'),
        ),
      ],
    );
  }
}
