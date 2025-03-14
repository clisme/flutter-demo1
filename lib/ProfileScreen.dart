import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
 final String? userId;

   ProfileScreen({super.key, this.userId});

  // const ProfileScreen({super.key, required this.userId});
  // ProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const Placeholder();
    return Text('也, $userId');
  }
}