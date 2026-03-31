import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen>
    with SingleTickerProviderStateMixin {

  // ── Add all your image paths here ──────────────────────────
  static const List<String> _images = [
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
    // keep adding...
  ];

  late AnimationController _ctrl;
  late Animation<double> _fade;
  late String _imagePath;

  @override
  void initState() {
    super.initState();
    _imagePath = _images[Random().nextInt(_images.length)];

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),   // fast fade in
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);

    // Force full-screen (hide status/nav bars)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _ctrl.forward();

    // Auto-dismiss after 300ms
    Future.delayed(const Duration(milliseconds: 300), _dismiss);
  }

  void _dismiss() async {
    await _ctrl.reverse();
    if (mounted) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _dismiss,
        child: FadeTransition(
          opacity: _fade,
          child: SizedBox.expand(
            child: Image.asset(
              _imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}