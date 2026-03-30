import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/settings_model.dart';
import '../center_button/center_button_screen.dart';
import '../gallery/gallery_screen.dart';
import '../home/home_screen.dart';
import '../meditation/meditation_screen.dart';
import '../settings/settings_dialogue.dart';
import '../settings/settings_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int currentIndex = 0;
  final ImagePicker _picker = ImagePicker();

  // Settings state
  SettingsModel settings = SettingsModel();

  final List<Widget> screens = const [
    HomeScreen(),
    GalleryScreen(),
    CenterButtonScreen(),
    MeditationScreen(),
    SettingsScreen(),
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

    if (index == 2) {
      // Show settings dialog directly when circle button is tapped
      _showSettingsDialog();
      return;
    }

    setState(() {
      currentIndex = index;
    });
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SettingsDialog(
          settings: settings,
          onSave: (updatedSettings) {
            setState(() {
              settings = updatedSettings;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final showCenterButton = currentIndex == 0;

    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          body: screens[currentIndex],
          bottomNavigationBar: _buildBottomNav(showCenterButton),
        ),

        /// FLOATING CENTER BUTTON (only on Home screen)
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
                    colors: [
                      Colors.white,
                      Color(0xFFD9C3B8),
                    ],
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
                    )
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

  Widget _buildBottomNav(bool showCenterButton) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFE8DCD6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: showCenterButton
            ? [
          _navItem(Icons.home, 0),
          _navItem(Icons.photo, 1),
          const SizedBox(width: 60), // space for center button
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