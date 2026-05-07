import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/custom_background.dart';
import '../../widget/custom_gradientBorder_button.dart';
import 'free_trial_pricing_screen.dart';


/// ======================================================
/// FIRST SCREEN
/// ======================================================

class FreeTrialIntroScreen extends StatelessWidget {
  const FreeTrialIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                /// Skip
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => const FreeTrialPricingScreen());
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                /// Title
                const Text(
                  'Souliminal subtly\nflashes your positive images\nwhile you use your device.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 20),

                /// Description
                Text(
                  'This isn’t traditional visionboards.\nThis isn’t scripting.\nThis is manifestation evolved\non a whole new level.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),

                const Spacer(),

                /// Next Button - Using GradientBorderButton
                GradientBorderButton(
                  text: "Next",
                  onTap: () {
                    Get.to(() => const FreeTrialPricingScreen());
                  },
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


