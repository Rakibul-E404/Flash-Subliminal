import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:subliminal/widget/custom_background_two.dart';
import '../../widget/custom_background.dart';   // Your existing custom background

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundTwo(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
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
                          // 'About Souliminal',
                          'About Souliminal',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(width: 30),
                      ],
                    ),
                  ),


                  const SizedBox(height: 40),

                  // Main Description
                  _buildParagraph(
                    "Souliminal is a subconscious reprogramming tool for those who want quiet, gentle, continuous transformation while going about their day.",
                  ),

                  const SizedBox(height: 24),

                  _buildParagraph(
                    "It uses rapid visual image flashes — personal images you upload yourself — shown subtly in the background while you browse, read, or work.",
                  ),

                  const SizedBox(height: 24),

                  _buildParagraph(
                    "These micro-second flashes speak directly to your subconscious without interrupting your flow.",
                  ),

                  const SizedBox(height: 24),

                  _buildParagraph(
                    "This isn’t traditional vision boarding.\n"
                        "This isn’t just scripting.\n"
                        "This is manifestation evolved on a whole new level.",
                  ),

                  const SizedBox(height: 40),

                  // Section Title
                  const Text(
                    'How Image Subliminal Flashing Works',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _buildParagraph(
                    "Your subconscious responds instantly to visuals. When seen for a fraction of a second, images tied to your goals, identity, and highest self leave a powerful imprint.",
                  ),

                  const SizedBox(height: 20),

                  _buildParagraph(
                    "Souliminal keeps these images active in your subconscious, helping you:",
                  ),

                  const SizedBox(height: 16),

                  // Bullet Points
                  _buildBulletPoint("Build an unshakable self-image"),
                  _buildBulletPoint("Reinforce intentions on autopilot"),
                  _buildBulletPoint("Align your mind with your desired reality"),
                  _buildBulletPoint("Reprogram limiting beliefs"),
                  _buildBulletPoint("Accelerate manifestation and personal growth"),

                  const SizedBox(height: 40),

                  // Meditation Mode Section
                  const Text(
                    'Meditation Mode',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _buildParagraph(
                    "When you want to pause and reconnect, Souliminal offers a calming Meditation Mode.\n\n"
                        "• Flowing aurora visuals\n"
                        "• gentle subliminal flashes\n"
                        "• and frequency soundscapes\nguide your mind into alpha and theta states — enhancing subconscious receptivity.",
                  ),

                  const SizedBox(height: 20),

                  _buildParagraph(
                    "It’s a peaceful space to breathe, realign, and set intentions.",
                  ),

                  const SizedBox(height: 40),

                  // Closing Line
                  Center(
                    child: Text(
                      "Your mind is powerful.\n"
                          "And your daily habits shape who you become.",
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.6,
                        color: Colors.black.withOpacity(0.95),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
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

  // Reusable Paragraph Widget
  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 17,
        height: 1.65,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  // Reusable Bullet Point
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "• ",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 17,
                height: 1.6,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}