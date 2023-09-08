import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String imageUrl;
  final String buttonName;
  final VoidCallback onPressed;

  CustomButton({required this.imageUrl, required this.buttonName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Column(
        children: <Widget>[
          Image.asset(
            imageUrl,
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 40),
          Text(
            buttonName,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}