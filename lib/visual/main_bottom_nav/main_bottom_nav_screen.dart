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

  // FIXED: Remove 'const' keyword
  final List<Widget> screens = [
    const HomeScreen(),
    const GalleryScreen(),
    // const CenterButtonScreen(),
    const MeditationScreen(),
    const SettingsScreen(),
  ];

  Future<void> openGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image selected: ${image.name}')),
      );
    }
  }

  void onTap(int index) async {
    if (index == 1) {
      await openGallery();
      return;
    }

    // Circle button - use the separate handler
    if (index == 2) {
      _handleCenterButtonTap();
      return;
    }

    if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()),
      );
      return;
    }

    setState(() {
      currentIndex = index;
    });
  }

  // Method to handle center button functionality using separate file
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

    return Stack(
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
                    _navItem(Icons.home, 0),
                    _navItem(Icons.photo, 1),
                    const SizedBox(width: 70),
                    _navItem(Icons.self_improvement, 3),
                    _navItem(Icons.settings, 4),
                  ]
                      : [
                    _navItem(Icons.home, 0),
                    _navItem(Icons.photo, 1),
                    _navItem(Icons.self_improvement, 3),
                    _navItem(Icons.settings, 4),
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
              onTap: () => onTap(2),
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
    );
  }

  Widget _navItem(IconData icon, int index) {
    final isSelected = currentIndex == index;
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