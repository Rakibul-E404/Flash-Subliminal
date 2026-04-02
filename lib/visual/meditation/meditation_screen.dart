
import 'package:flutter/material.dart';
import '../../models/settings_model.dart';
import '../settings/settings_dialogue.dart';

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  bool _isPlaying = false;

  // Default settings
  SettingsModel _currentSettings = SettingsModel(
    position: 'Centre',
    showEvery: '1 s',
    imageSize: 'Full',
    sessionLength: '30 m',
    audioOptions: 'Off',
  );

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }



  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => SettingsDialogSystem(  // Changed to SettingsDialogSystem
        settings: _currentSettings,
        onSave: (newSettings) {
          setState(() {
            _currentSettings = newSettings;
          });
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 🖼 BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              'assets/images/meditation.png',
              fit: BoxFit.cover,
            ),
          ),

          // 🔽 BOTTOM SECTION
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🔘 START SESSION BUTTON WITH GRADIENT BORDER
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0xFF6B8E9F), // Blue-gray
                          Color(0xFF7FA894), // Green-gray
                          Color(0xFFA8C5B8), // Light green
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2), // Border width
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFF5A7A8A), // Slightly darker blue-gray
                              Color(0xFF6B9A84), // Slightly darker green-gray
                            ],
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: _showSettingsDialog, // Open settings dialog
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 60,
                              vertical: 18,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Start Session',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}