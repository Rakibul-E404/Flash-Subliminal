import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth/sign_in_screen.dart';
import '../../widget/custom_background.dart';
import '../../widget/custom_gradientBorder_button.dart';

/// ======================================================
/// SECOND SCREEN
/// ======================================================

class FreeTrialPricingScreen extends StatefulWidget {
  const FreeTrialPricingScreen({super.key});

  @override
  State<FreeTrialPricingScreen> createState() => _FreeTrialPricingScreenState();
}

class _FreeTrialPricingScreenState extends State<FreeTrialPricingScreen> {
  String selectedPackage = 'yearly'; // 'monthly' or 'yearly'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 40),

                /// Title
                const Text(
                  'Begin Your\nSubconscious Reset',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 24),

                /// Divider Glow
                Image.asset(
                  'assets/icons/divider_glow.png',
                  width: double.infinity,
                  height: 25,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 30),

                /// Subtitle
                Text(
                  '7 days free.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your transformation continues with full\n access-the choice is yours.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 0),

                /// Glow Ring with Pricing
                Expanded(
                  child: Center(
                    child: _buildPricingRing(),
                  ),
                ),

                /// Footer
                Text(
                  '\$9.99/month after trial. Cancel anytime.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 50),

                /// CTA Button - Using GradientBorderButton
                GradientBorderButton(
                  text: "Start My Free Trial  →",
                  onTap: () {
                    Get.to(() => const SignInScreen());
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

  /// ======================================================
  /// GLOW RING WITH PRICING OPTIONS
  /// ======================================================

  Widget _buildPricingRing() {
    return SizedBox(
      width: 520,
      height: 330,
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// PNG RING
          Image.asset(
            'assets/icons/glowing_ring.png',
            width: 520,
            height: 520,
            fit: BoxFit.contain,
          ),

          /// Monthly Pricing - Top
          Positioned(
            top: 90,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedPackage = 'monthly';
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                decoration: BoxDecoration(
                  color: selectedPackage == 'monthly'
                      ? Colors.white.withOpacity(0.30)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: selectedPackage == 'monthly'
                        ? Colors.white.withOpacity(0.8)
                        : Colors.transparent,
                    width: selectedPackage == 'monthly' ? 1 : 0,
                  ),
                  boxShadow: selectedPackage == 'monthly'
                      ? [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ]
                      : null,
                ),
                child: Column(
                  children: [
                    const Text(
                      "Monthly",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "\$9.99",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 6),
                          child: Text(
                            "/month",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        if (selectedPackage == 'monthly') ...[
                          const SizedBox(width: 8),

                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// Yearly Pricing - Bottom (Best Value)
          Positioned(
            bottom: 90,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedPackage = 'yearly';
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                decoration: BoxDecoration(
                  color: selectedPackage == 'yearly'
                      ? Colors.white.withOpacity(0.30)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: selectedPackage == 'yearly'
                        ? Colors.white.withOpacity(0.8)
                        : Colors.transparent,
                    width: selectedPackage == 'yearly' ? 1 : 0,
                  ),
                  boxShadow: selectedPackage == 'yearly'
                      ? [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ]
                      : null,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Best Value",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        if (selectedPackage == 'yearly') ...[
                          const SizedBox(width: 8),

                        ],
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "\$59.99",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 6),
                          child: Text(
                            "/year",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}