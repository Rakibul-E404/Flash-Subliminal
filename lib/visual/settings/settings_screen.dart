import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../widget/custom_background.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:subliminal/core/app_text_style.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomBackground(
        child: Column(
          children: [
            // Centered title with home button - matches screenshot layout
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 20 /* bottom: 20*/),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black54, Colors.transparent],
                ),
              ),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                    ),
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                children: const [
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
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: IconButton(onPressed: (){
            //     Get.back();
            //   }, icon: Icon(Icons.home,color: Colors.white,size: 20,)),
            // ),
            SizedBox(height: 20),
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
                ), // Button-like padding
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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Opening $title...')));
  }
}
