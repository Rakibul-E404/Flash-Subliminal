
import 'dart:ui';
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

    // Circle button → show board selection first, then settings dialog
    if (index == 2) {
      _showBoardSelectionDialog();
      return;
    }

    if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsScreen()),
      );
      return;
    }

    setState(() {
      currentIndex = index;
    });
  }

  // ══════════════════════════════════════════════════════════════════════════
  //  STEP 1 — Board Selection Alert Dialog
  //  Shown when the circle button is tapped.
  //  After user picks a board and taps Next → _showSettingsDialog() is called.
  // ══════════════════════════════════════════════════════════════════════════

  void _showBoardSelectionDialog() {
    int? tempSelectedIndex = _selectedBoardIndex;

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 48),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF3EDE8),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.20),
                      blurRadius: 40,
                      offset: const Offset(0, 14),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ── Header ──────────────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                      child: Row(
                        children: [
                          // Back / close button
                          GestureDetector(
                            onTap: () => Navigator.pop(dialogContext),
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.85),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.09),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 15,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Select a Board',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── 2×2 Board Grid ───────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.88,
                        ),
                        itemCount: _boards.length,
                        itemBuilder: (context, index) {
                          final board = _boards[index];
                          final bool isSelected = tempSelectedIndex == index;

                          return GestureDetector(
                            onTap: () => setDialogState(
                                    () => tempSelectedIndex = index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF8BBDBB)
                                      : Colors.grey.shade200,
                                  width: isSelected ? 2.5 : 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: isSelected
                                        ? const Color(0xFF8BBDBB)
                                        .withOpacity(0.30)
                                        : Colors.black.withOpacity(0.06),
                                    blurRadius: isSelected ? 14 : 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(17),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    // Board image
                                    Image.asset(
                                      board['assetPath'],
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          _imageFallback(index),
                                    ),

                                    // Gradient scrim for readability
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      height: 64,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.40),
                                              Colors.transparent,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Board name label
                                    Positioned(
                                      bottom: 7,
                                      left: 6,
                                      right: 6,
                                      child: Text(
                                        board['name'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 4,
                                              color: Colors.black45,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Checkmark badge when selected
                                    if (isSelected)
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: Container(
                                          width: 22,
                                          height: 22,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF8BBDBB),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(Icons.check,
                                              color: Colors.white, size: 14),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // ── Next Button ──────────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 0, 14, 18),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: tempSelectedIndex != null
                              ? () {
                            // Save the chosen board index
                            setState(() =>
                            _selectedBoardIndex = tempSelectedIndex);
                            // Close board selection dialog
                            Navigator.pop(dialogContext);
                            // Open settings dialog after dismiss animation
                            Future.delayed(
                              const Duration(milliseconds: 180),
                              _showSettingsDialog,
                            );
                          }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tempSelectedIndex != null
                                ? const Color(0xFF8BBDBB)
                                : Colors.grey.shade300,
                            foregroundColor: Colors.white,
                            disabledForegroundColor: Colors.white60,
                            disabledBackgroundColor: Colors.grey.shade300,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Fallback widget shown if an asset image fails to load
  Widget _imageFallback(int index) {
    const gradients = [
      [Color(0xFFCDD8E3), Color(0xFFDDE8F0)],
      [Color(0xFFD5D5DF), Color(0xFFE8E8EE)],
      [Color(0xFFEDE8E2), Color(0xFFF3EFE9)],
      [Color(0xFFE0D8CC), Color(0xFFEDE7DC)],
    ];
    const icons = [
      Icons.landscape_outlined,
      Icons.directions_car_outlined,
      Icons.favorite_outline,
      Icons.wb_sunny_outlined,
    ];
    final colors = gradients[index % gradients.length];
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: Center(
        child: Icon(icons[index % icons.length],
            size: 44, color: Colors.white.withOpacity(0.72)),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════
  //  STEP 2 — Settings Dialog  (original, unchanged)
  // ══════════════════════════════════════════════════════════════════════════

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
              onTap: () => onTap(2), // still calls onTap(2) → _showBoardSelectionDialog
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







