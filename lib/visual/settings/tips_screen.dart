import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:subliminal/widget/custom_background_two.dart';
import '../../widget/custom_background.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundTwo(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        const Text(
                          'Tips',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(width: 50),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Tips for using Souliminal effectively',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 40),

                  _buildSection(
                    title: 'Relaxation:',
                    content:
                    'Breathe deeply and relax to enter alpha or theta brain states, while using Souliminal, even as you do other tasks on your device. A calm brainwave system makes subliminal reprogramming more effective. Relaxation moves the brain into alpha and theta states, making the mind open, receptive and less guarded. Stress blocks the message—it is skin deep.',
                  ),

                  const SizedBox(height: 32),

                  _buildSection(
                    title: 'Hydrate:',
                    content:
                    'Your brain is 75% water. Staying hydrated fuels neural signaling, sharpens focus, and supercharges your mind. Think of subliminals like a workout for your brain—a hydrated mind absorbs messages more effectively.',
                  ),

                  const SizedBox(height: 32),

                  _buildSection(
                    title: 'Consistency:',
                    content:
                    'Repetition is the key to lasting change. Daily use produces the strongest results. Use short sessions to build current patterns, so rewriting takes time. Be patient—your subconscious gradually absorbs new programming and begins to shift, even before you consciously notice.',
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: const TextStyle(
            fontSize: 16.5,
            height: 1.65,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}