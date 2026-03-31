
import 'package:flutter/material.dart';

class CenterButtonScreen extends StatefulWidget {
  const CenterButtonScreen({super.key});

  @override
  State<CenterButtonScreen> createState() => _CenterButtonScreenState();
}

class _CenterButtonScreenState extends State<CenterButtonScreen> {
  // Settings variables
  bool runOnStartUp = false;
  String position = 'Centre';
  String showEvery = '3 s';
  String imageSize = 'Small';
  String sessionLength = 'Auto';
  String audioOptions = 'Frequency';

  // Board selection
  int? selectedBoard;

  @override
  Widget build(BuildContext context) {
    // If no board is selected yet, show board selection UI
    if (selectedBoard == null) {
      return _buildBoardSelectionScreen();
    }

    // Otherwise show the main screen with settings
    return _buildMainScreen();
  }

  Widget _buildBoardSelectionScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EC),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select a Board',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Choose the board that resonates with you',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Board grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.9,
                  children: [
                    _buildBoardCard(1, 'Board One'),
                    _buildBoardCard(2, 'Board Two'),
                    _buildBoardCard(3, 'Board Three', showText: true),
                    _buildBoardCard(4, 'Board Four'),
                  ],
                ),
              ),
            ),

            // Next button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedBoard != null ? _onNextPressed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedBoard != null
                        ? const Color(0xFFB8D4D3)
                        : Colors.grey.shade300,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
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

  Widget _buildBoardCard(int boardNumber, String title, {bool showText = false}) {
    bool isSelected = selectedBoard == boardNumber;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBoard = boardNumber;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFFB8D4D3) : Colors.grey.shade200,
            width: isSelected ? 3 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Board illustration
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFB8D4D3).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  _getBoardIcon(boardNumber),
                  size: 50,
                  color: const Color(0xFFB8D4D3),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            if (showText) ...[
              const SizedBox(height: 8),
              const Text(
                'Believe in Yourself',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getBoardIcon(int boardNumber) {
    switch (boardNumber) {
      case 1:
        return Icons.spa;
      case 2:
        return Icons.auto_awesome;
      case 3:
        return Icons.favorite;
      case 4:
        return Icons.stars;
      default:
        return Icons.circle;
    }
  }

  Widget _buildMainScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_circle, size: 64, color: Colors.brown),
            const SizedBox(height: 16),
            const Text(
              "Tap the floating button",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("to open settings"),
            const SizedBox(height: 24),

            // Display current settings
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Current Settings:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildSettingRow("Run on startup", runOnStartUp ? "Yes" : "No"),
                  _buildSettingRow("Position", position),
                  _buildSettingRow("Show every", showEvery),
                  _buildSettingRow("Image size", imageSize),
                  _buildSettingRow("Session length", sessionLength),
                  _buildSettingRow("Audio options", audioOptions),
                  const SizedBox(height: 8),
                  _buildSettingRow("Selected Board", "Board ${selectedBoard ?? 1}"),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Open settings button
            ElevatedButton.icon(
              onPressed: () => _showSettingsDialog(context),
              icon: const Icon(Icons.settings),
              label: const Text("Open Settings"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB8D4D3),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.brown,
            ),
          ),
        ],
      ),
    );
  }

  void _onNextPressed() {
    setState(() {});
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: const Color(0xFFF5F0EC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Position
                    const Text(
                      'Position',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSegmentedControl(
                      setDialogState,
                      ['Centre', 'Random'],
                      position,
                          (value) => position = value,
                    ),
                    const SizedBox(height: 24),

                    // Show Every
                    const Text(
                      'Show Every',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSegmentedControl(
                      setDialogState,
                      ['300 ms', '1 s', '3 s', '5s'],
                      showEvery,
                          (value) => showEvery = value,
                    ),
                    const SizedBox(height: 24),

                    // Image Size
                    const Text(
                      'Image Size',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSegmentedControl(
                      setDialogState,
                      ['Small', 'Full'],
                      imageSize,
                          (value) => imageSize = value,
                    ),
                    const SizedBox(height: 24),

                    // Session Length
                    const Text(
                      'Session Length',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSegmentedControl(
                      setDialogState,
                      ['30 m', '40 m', '60 m', 'Auto'],
                      sessionLength,
                          (value) => sessionLength = value,
                    ),
                    if (sessionLength == 'Auto')
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          'Auto runs continuously until stopped',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    const SizedBox(height: 24),

                    // Audio Options
                    Row(
                      children: [
                        const Text(
                          'Audio Options',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.info_outline,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildSegmentedControl(
                      setDialogState,
                      ['Off', 'Frequency', 'Subliminal'],
                      audioOptions,
                          (value) => audioOptions = value,
                    ),
                    const SizedBox(height: 12),
                    if (audioOptions == 'Frequency')
                      const Text(
                        '• Frequency: pure sound frequencies only',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    if (audioOptions == 'Subliminal')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '• Frequency: pure sound frequencies only',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const Text(
                            '• Subliminal: affirmations embedded in audio',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),

                    // const SizedBox(height: 16),
                    // const Center(
                    //   child: Text(
                    //     'Save, then tap the circle to start Soulminimal Flash',
                    //     style: TextStyle(
                    //       fontSize: 12,
                    //       color: Colors.grey,
                    //       fontStyle: FontStyle.italic,
                    //     ),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    const SizedBox(height: 16),
                    // Close button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {});
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB8D4D3),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text('Save & Close'),
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

  Widget _buildSegmentedControl(
      StateSetter setDialogState,
      List<String> options,
      String selectedValue,
      Function(String) onSelected,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: options.asMap().entries.map((entry) {
          int idx = entry.key;
          String option = entry.value;
          bool isSelected = selectedValue == option;
          bool isLast = idx == options.length - 1;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setDialogState(() {
                  onSelected(option);
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFB8D4D3) : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(idx == 0 ? 25 : 0),
                    bottomLeft: Radius.circular(idx == 0 ? 25 : 0),
                    topRight: Radius.circular(isLast ? 25 : 0),
                    bottomRight: Radius.circular(isLast ? 25 : 0),
                  ),
                ),
                child: Center(
                  child: Text(
                    option,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}