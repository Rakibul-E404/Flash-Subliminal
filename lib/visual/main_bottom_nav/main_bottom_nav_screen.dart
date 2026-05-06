
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/settings_model.dart';
import '../home/home_center_button.dart';
import '../gallery/gallery_screen.dart';
import '../home/home_screen.dart';
import '../meditation/meditation_screen.dart';
import '../settings/settings_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int currentIndex = 0;
  final ImagePicker _picker = ImagePicker();

  SettingsModel settings = SettingsModel();

  // Tracks which board the user selected in the board-selection alert
  int? _selectedBoardIndex;

  // Board data — matches the boards in HomeScreen so cards show real images
  final List<Map<String, dynamic>> _boards = [
    {
      'name': 'Board One',
      'assetPath': 'assets/images/image1.png',
      'isLocal': true,
      'imageFile': null,
    },
    {
      'name': 'Board Two',
      'assetPath': 'assets/images/image2.png',
      'isLocal': true,
      'imageFile': null,
    },
    {
      'name': 'Board Three',
      'assetPath': 'assets/images/image3.png',
      'isLocal': true,
      'imageFile': null,
    },
    {
      'name': 'Board Four',
      'assetPath': 'assets/images/image4.png',
      'isLocal': true,
      'imageFile': null,
    },
  ];

  // Only 3 screens now (Home, Gallery, Meditation)
  final List<Widget> screens = [
    const HomeScreen(),        // index 0
    const GalleryScreen(),     // index 1
    const MeditationScreen(),  // index 2
  ];

  Future<void> openGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image selected: ${image.name}'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: 90,
            left: 16,
            right: 16,
          ),
        ),
      );
    }
  }

  void onTap(int index) async {
    // Handle gallery button (index 1)
    if (index == 1) {
      await openGallery();
      return;
    }

    // Handle center/circle button (index 2 in the nav)
    if (index == 2) {
      _handleCenterButtonTap();
      return;
    }

    // Handle settings button (index 4)
    if (index == 4) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()),
      );

      // Handle settings updates if returned
      if (result != null && result is SettingsModel) {
        setState(() {
          settings = result;
        });
      }
      return;
    }

    // For home and meditation navigation items
    if (index == 0) {
      setState(() {
        currentIndex = 0; // Home
      });
    } else if (index == 3) {
      setState(() {
        currentIndex = 2; // Meditation (maps to screen index 2)
      });
    }
  }

  // Method to handle center button functionality
  void _handleCenterButtonTap() {
    final homeCenterButton = HomeCenterButton(
      context: context,
      boards: _boards,
      settings: settings,
      onBoardSelected: (selectedIndex) {
        setState(() {
          _selectedBoardIndex = selectedIndex;
        });
        print('Selected board index: $selectedIndex');
      },
      onSettingsSaved: (updatedSettings) {
        setState(() {
          settings = updatedSettings;
        });
      },
    );

    homeCenterButton.showBoardSelectionAndSettings();
  }

  @override
  Widget build(BuildContext context) {
    final showCenterButton = currentIndex == 0;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Screens fill the background
          Positioned.fill(
            child: screens[currentIndex],
          ),

          // Bottom navigation bar (glass effect)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: showCenterButton
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.spaceEvenly,
                    children: showCenterButton
                        ? [
                      _navItem(Icons.home, 0),              // Home
                      _navItem(Icons.photo, 1),             // Gallery
                      const SizedBox(width: 70),            // Space for center button
                      _navItem(Icons.self_improvement, 3),  // Meditation
                      _navItem(Icons.settings, 4),          // Settings (pushes new screen)
                    ]
                        : [
                      _navItem(Icons.home, 0),              // Home
                      _navItem(Icons.photo, 1),             // Gallery
                      _navItem(Icons.self_improvement, 3),  // Meditation
                      _navItem(Icons.settings, 4),          // Settings (pushes new screen)
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Floating center button above the bottom nav
          if (showCenterButton)
            Positioned(
              bottom: 40,
              child: GestureDetector(
                onTap: () => onTap(2), // Special center button handler
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      colors: [Colors.white, Color(0xFFD9C3B8)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                      BoxShadow(
                        color: Colors.white.withOpacity(0.8),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/circle_button.svg',
                      width: 70,
                      height: 70,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, int index) {
    // Determine if this nav item is selected
    bool isSelected = false;
    if (index == 0) {
      isSelected = currentIndex == 0; // Home
    } else if (index == 3) {
      isSelected = currentIndex == 2; // Meditation
    }
    // Gallery (index 1) and Settings (index 4) don't have selected states
    // because Gallery triggers an action and Settings pushes a new screen

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: isSelected ? Colors.black : Colors.grey,
          ),
        ],
      ),
    );
  }
}