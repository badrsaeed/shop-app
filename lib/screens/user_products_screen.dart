import 'package:flutter/material.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product-screen';
  const UserProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UserProductScreen"),
      ),
      body: Center(
        child: Text("UserProductScreen"),
      ),
    );
  }
}
