import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../auth/sign_in_screen.dart';
import '../../widget/custom_background.dart';
import '../../widget/custom_button.dart';

class FreeTrialInfoScreen extends StatefulWidget {
  const FreeTrialInfoScreen({super.key});

  @override
  State<FreeTrialInfoScreen> createState() => _FreeTrialInfoScreenState();
}

class _FreeTrialInfoScreenState extends State<FreeTrialInfoScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground( // ✅ USING YOUR BACKGROUND
        child: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: _currentStep == 0
                ? _buildFirstPage()
                : _buildSecondPage(),
          ),
        ),
      ),
    );
  }

  /// ================= FIRST PAGE =================
  Widget _buildFirstPage() {
    return Padding(
      key: const ValueKey(0),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          /// Skip
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                setState(() => _currentStep = 1);
              },
              child: const Text(
                "Skip",
                style: TextStyle(color: Colors.white),
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

          /// Next Button
          GradientBorderButton(
            text: "Next",
            onTap: () {
              setState(() => _currentStep = 1);
            },
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  /// ================= SECOND PAGE =================
  Widget _buildSecondPage() {
    return Padding(
      key: const ValueKey(1),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 20),

          /// Title
          const Text(
            'Begin Your\nSubconscious Reset',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 16),

          /// Subtitle
          Text(
            '7 days free.\nYour transformation continues with full access - the choice is yours.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 30),

          // /// Monthly
          // const Text(
          //   'Monthly\n\$9.99/month',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 18,
          //     height: 1.4,
          //   ),
          // ),

          const SizedBox(height: 30),

          /// Glow Pricing
          _glowYearly(),

          const Spacer(),


          /// CTA Button
          GradientBorderButton(
            text: "Start My Free Trial →",
            onTap: () {
              Get.to(() => SignInScreen());
            },
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  /// ================= GLOW YEARLY =================
  Widget _glowYearly() {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// ✅ SVG RING (bigger like design)
          SvgPicture.asset(
            'assets/icons/glowing_ring.svg',
            width: 300,
            height: 300,
            fit: BoxFit.contain,
          ),

          /// ✅ Monthly text INSIDE ring (top)
          Positioned(
            top: 90,
            child: Column(
              children: const [
                Text(
                  "Monthly",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "\$9.99",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "/month",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          /// ✅ Glass card (center)
          Positioned(
            bottom: 70,
            child: Container(
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              child: Column(
                children: const [
                  Text(
                    "Best Value",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "\$59.99/year",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}