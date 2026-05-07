import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:subliminal/widget/custom_background_two.dart';
import '../../widget/custom_background.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

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
                          'Terms & Conditions',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),



                  const SizedBox(height: 12),

                  const Text(
                    'Effective Date: Feb-03-2026',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Welcome to Souliminal Flash. By downloading, accessing, or using this app, you agree to these Terms of Service. If you do not agree, do not use the app.\n\n'
                        '1. Eligibility\n'
                        'Souliminal is intended for adult use only (18+). Use by children under 18 is strictly prohibited. Teenagers (13-17) may only use the app under parental supervision and with guidance from a healthcare professional.\n\n'
                        '2. Use of the App\n'
                        'Souliminal provides subliminal image flashing and meditation features for personal development.\n\n'
                        'Users may upload their own images for subliminal sessions. Uploaded content must be positive, safe, and comply with copyright laws.\n\n'
                        'Users are prohibited from uploading offensive, illegal, or harmful content.\n\n'
                        '3. Health and Safety\n'
                        'The app is not recommended for people with epilepsy or photosensitive conditions, as flashing images could trigger seizures. Use of the app does not replace medical or mental health advice. Consult a healthcare professional if you have concerns about app usage.\n\n'
                        'Always use the app in a safe, calm environment.\n\n'
                        '4. Intellectual Property\n'
                        'Souliminal and its content are owned by [Your Company Name].',
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