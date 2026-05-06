import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:subliminal/visual/home/home_screen.dart';
import 'package:subliminal/visual/main_bottom_nav/main_bottom_nav_screen.dart';
import 'package:subliminal/visual/settings/about_screen.dart';
import 'package:subliminal/visual/settings/contact_screen.dart';
import 'package:subliminal/visual/settings/dedication_screen.dart';
import 'package:subliminal/visual/settings/faq_screen.dart';
import 'package:subliminal/visual/settings/privacy_policy_screen.dart';
import 'package:subliminal/visual/settings/reminders_screen.dart';
import 'package:subliminal/visual/settings/subscription_screen.dart';
import 'package:subliminal/visual/settings/terms_condition_screen.dart';
import 'package:subliminal/visual/settings/tips_screen.dart';
import '../../widget/custom_background.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:subliminal/core/app_text_style.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'account_screen.dart'; // Import the account screen

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomBackground(
        child: Column(
          children: [
            // Centered title
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black54, Colors.transparent],
                ),
              ),
              child: SafeArea(
                child: Center(  // Changed to Center widget
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                children: [
                  SettingsItem(icon: CupertinoIcons.person_alt_circle, title: 'Account'),
                  SettingsItem(
                    icon: Icons.notifications,
                    title: 'Reminders',
                  ),
                  SettingsItem(
                    icon: Icons.diamond,
                    title: 'Subscription',
                  ),
                  SettingsItem(
                    icon: Icons.favorite,
                    title: 'Dedication',
                  ),
                  SettingsItem(icon: Icons.info, title: 'About Us'),
                  SettingsItem(
                    icon: Icons.headset_mic,
                    title: 'Contact',
                  ),
                  SettingsItem(icon: CupertinoIcons.chat_bubble_2_fill, title: 'FAQs'),
                  SettingsItem(icon: Icons.lightbulb, title: 'Tips'),
                  SettingsItem(
                    icon: Icons.description,
                    title: 'Terms & Condition',
                  ),
                  SettingsItem(
                    icon: CupertinoIcons.checkmark_shield_fill,
                    title: 'Privacy Policy',
                  ),
                ],
              ),
            ),
            // Home button at bottom center
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Get.back(); // Navigate back to home screen
                    Get.to(()=>MainBottomNavScreen()); // Navigate back to home screen
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: const Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const SettingsItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _handleTap(context, title),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.1),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(icon, color: Colors.black, size: 26),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyle.defaultTextStyleBlack.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_right, color: Colors.black, size: 26),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleTap(BuildContext context, String title) {
    if (title == 'Account') {
      Get.to(()=> const AccountScreen());
    }
    else if(title == 'Reminders'){
      Get.to(()=> const RemindersScreen());
    }
    else if(title == 'Subscription'){
      Get.to(()=> const SubscriptionScreen());
    }
    else if(title == 'Dedication'){
      Get.to(()=> const DedicationScreen());
    }
    else if(title == 'About Us'){
      Get.to(()=> const AboutScreen());
    }
    else if(title == 'FAQs'){
      Get.to(()=> const FaqScreen());
    }
    else if(title == 'Contact'){
      Get.to(()=> const ContactScreen());
    }
    else if(title == 'Tips'){
      Get.to(()=> const TipsScreen());
    }
    else if(title == 'Terms & Condition'){
      Get.to(()=> const TermsConditionScreen());
    }
    else if(title == 'Privacy Policy'){
      Get.to(()=> const PrivacyPolicyScreen());
    }
    else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Opening $title...')));
    }
  }
}