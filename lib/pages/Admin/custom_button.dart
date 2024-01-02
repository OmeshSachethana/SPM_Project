import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String imageUrl;
  final String buttonName;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.imageUrl, required this.buttonName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Column(
        children: <Widget>[
          Image.asset(
            imageUrl,
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 10),
          Text(
            buttonName,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}