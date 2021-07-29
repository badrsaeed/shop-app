import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CartScreen"),
      ),
      body: Center(
        child: Text("CartScreen"),
      ),
    );
  }
}
