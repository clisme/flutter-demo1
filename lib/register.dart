import 'package:flutter/material.dart';
import 'package:flutter_application_1/UserStorage.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: '用户名',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '密码',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // 注册逻辑
                final username = _usernameController.text;
                final password = _passwordController.text;
                if (username.isNotEmpty && password.isNotEmpty) {
                UserStorage.saveUser( username,password);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('注册成功')),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('用户名和密码不能为空')),
                  );
                }
              },
              child: Text('注册'),
            ),
          ],
        ),
      ),
    );
  }
}