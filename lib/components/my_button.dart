import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Color color;
  final double? width;
  final double? height;
  final Function()? onPressed;

  const MyButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.width = 350.0,
    this.height = 50.0
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
              width: width,
              height: height,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 0,
                ),
              child: Text(text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black
              ),
              ),
            ),
          );
  }
}