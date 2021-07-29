import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order-screen';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OrderScreen"),
      ),
      body: Center(
        child: Text("OrderScreen"),
      ),
    );
  }
}
