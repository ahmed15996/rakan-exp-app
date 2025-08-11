import 'package:flutter/material.dart';

class OrderNumberScreen extends StatelessWidget {
  final String orderNumber;

  const OrderNumberScreen({super.key, required this.orderNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(
                '#$orderNumber',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 120,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
