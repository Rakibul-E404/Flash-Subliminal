import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../widget/custom_background_two.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
                          'Privacy Policy',
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



                  const SizedBox(height: 12),

                  const Text(
                    'Effective Date: Feb-03-2026',
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Souliminal (“we,” “our,” or “the app”) is committed to protecting your privacy. This Privacy Policy explains how we collect, use, and protect your personal information. By using the app, you agree to this policy.\n\n'
                        '1. Adult Use Only\n'
                        'Souliminal is intended for adults (18+). The app is not designed for children, and anyone under 18 should not use the app.\n\n'
                        '2. Information We Collect\n'
                        'We collect the following types of information:\n'
                        '• User-provided information: images you upload for subliminal sessions.\n'
                        '• Device information: app actions, features, device type, operating system and usage.\n'
                        '• We do not knowingly collect personal information from children under 18.\n\n'
                        '3. How We Use Your Information\n'
                        'We use your information to:\n'
                        '• Deliver subliminal image flashing and meditation\n'
                        '• Improve app performance and fix technical issues\n'
                        '• Communicate important notices about the app\n'
                        '• Your uploaded images are stored internally to provide the app experience.\n\n'
                        '4. Storage and Security\n'
                        'We implement reasonable technical measures to protect your uploaded images stored internally or online to provide the app experience.',
                    style: TextStyle(
                      fontSize: 16.5,
                      height: 1.65,
                      color: Colors.black,
                    ),
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
}