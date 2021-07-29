import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  static const routeName = '/edit-product-screen';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EditProductScreen"),
      ),
      body: Center(
        child: Text("EditProductScreen"),
      ),
    );
  }
}
