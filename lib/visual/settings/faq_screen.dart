import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:subliminal/widget/custom_background_two.dart';
import '../../widget/custom_background.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final Map<String, bool> _expandedMap = {};

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundTwo(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
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
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const Text(
                          'FAQ',
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


                  const SizedBox(height: 24),

                  // Important Note
                  Text(
                    'Important: Souliminal is designed for adult use only (18+).\n'
                        'It is not recommended for children and may not be suitable for teenagers without supervision. '
                        'People with photosensitive epilepsy or other neurological conditions should consult a healthcare professional before use.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.55,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Section 1
                  _buildSection(
                    title: '1. Safety, Suitability & Reassurance',
                    items: [
                      'Is Souliminal flash safe?',
                      'Can Subliminal Flash override my free will?',
                      'Can Subliminal Flash cause negative effects?',
                      'Can I overdo Subliminal Flash?',
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Section 2
                  _buildSection(
                    title: '2. How Subliminal Flash Works',
                    items: [
                      'Can Subliminal Flash work even if I don\'t consciously believe it?',
                      'What happens in the brain during Subliminal Flash?',
                      'Visual or auditory subliminals — which is better?',
                      'Do I need to be relaxed to see results?',
                      'Why are default affirmation images part of every session?',
                      'Why is there only one video and sound option in Meditation Mode?',
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Section 3
                  _buildSection(
                    title: '3. Results, Progress & Integration',
                    items: [
                      'How long until I notice results?',
                      'Can results fade if I stop using Subliminal Flash?',
                      'Does Subliminal Flash work differently for everyone?',
                      'Is it working if I don\'t feel anything?',
                      'Why do I feel emotional or tired after Subliminal Flash?',
                      'Is detachment important with Subliminal Flash?',
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Section 4
                  _buildSection(
                    title: '4. Best Practices & Optimising Results',
                    items: [
                      'How often should I use the app?',
                      'How do I maintain the best results?',
                      'What if I miss a day?',
                      'Why hydration matters during subliminals?',
                    ],
                  ),

                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<String> items}) {
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
        const SizedBox(height: 16),
        ...items.map((question) => _buildFaqItem(question)),
      ],
    );
  }

  Widget _buildFaqItem(String question) {
    final isExpanded = _expandedMap[question] ?? false;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _expandedMap[question] = !isExpanded;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                // Circular dropdown icon
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Question Text
                Expanded(
                  child: Text(
                    question,
                    style: const TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Expanded Answer (Dummy for now)
        if (isExpanded)
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.10),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'This is a dummy answer. The actual content will be fetched from the API during integration.\n\n'
                  'Souliminal uses advanced micro-second image flashing technology to gently reprogram your subconscious mind while you go about your daily activities.',
              style: TextStyle(
                fontSize: 15.5,
                height: 1.6,
                color: Colors.black54,
              ),
            ),
          ),
      ],
    );
  }
}