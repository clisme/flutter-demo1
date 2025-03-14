import 'package:flutter/material.dart';
import 'register.dart';
import 'package:flutter_application_1/UserStorage.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
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
              onPressed: () async {
                // 登录逻辑
                final username = _usernameController.text;
                final password = _passwordController.text;
                var c = await UserStorage.getUser(username, password);
                // String jsonString = jsonEncode(c);
                print(c);
                if (username == 'admin' && password == '123456') {
                  Navigator.pushReplacementNamed(context, '/');
                } else if (c) {
                  Navigator.pushReplacementNamed(context, '/');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('用户名或密码错误')),
                  );
                }
              },
              child: Text('登录'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('没有账号？立即注册'),
            ),
          ],
        ),
      ),
    );
  }
}
