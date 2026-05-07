import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientBorderButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double width;
  final double height;

  const GradientBorderButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width = double.infinity,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          /// 🔥 Outer Border Gradient
          gradient: const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xff7d91aa),
              Color(0xffb3bfaf),
            ],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.all(1.5), // thinner = more premium
        child: Container(
          decoration: BoxDecoration(
            /// ✨ Inner Gradient (button fill)
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff7d91aa),
                Color(0xffb3bfaf),
              ],
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}