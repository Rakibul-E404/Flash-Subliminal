import 'package:flutter/material.dart';
import 'package:subliminal/core/app_text_style.dart';
import '../../models/settings_model.dart';
import '../settings/settings_dialogue.dart';

class HomeCenterButton {
  final List<Map<String, dynamic>> boards;
  final SettingsModel settings;
  final Function(int) onBoardSelected;
  final Function(SettingsModel) onSettingsSaved;
  final BuildContext context;

  HomeCenterButton({
    required this.context,
    required this.boards,
    required this.settings,
    required this.onBoardSelected,
    required this.onSettingsSaved,
  });

  // Main method to show the complete flow
  void showBoardSelectionAndSettings() {
    _showBoardSelectionDialog();
  }

  // STEP 1: Board Selection Dialog
  void _showBoardSelectionDialog() {
    int? tempSelectedIndex;

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
                    // Header
                    _buildHeader(dialogContext),

                    // Board Grid
                    _buildBoardGrid(setDialogState, tempSelectedIndex, (index) {
                      setDialogState(() => tempSelectedIndex = index);
                    }),

                    // Next Button
                    _buildNextButton(tempSelectedIndex, dialogContext),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Build Header Widget
  Widget _buildHeader(BuildContext dialogContext) {
    return Padding(
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
    );
  }

  // Build Board Grid
  Widget _buildBoardGrid(
      StateSetter setDialogState,
      int? tempSelectedIndex,
      Function(int) onBoardTap,
      ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.88,
        ),
        itemCount: boards.length,
        itemBuilder: (context, index) {
          final board = boards[index];
          final bool isSelected = tempSelectedIndex == index;

          return GestureDetector(
            onTap: () => onBoardTap(index),
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
                        ? const Color(0xFF8BBDBB).withOpacity(0.30)
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
                      errorBuilder: (_, __, ___) => _imageFallback(index),
                    ),
                    // Gradient scrim
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
                    // Board name
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
                    // Checkmark
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
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Build Next Button
  Widget _buildNextButton(int? tempSelectedIndex, BuildContext dialogContext) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(80, 0, 80, 18),
      child: SizedBox(
        width: double.infinity,
        child:
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff7d91aa),
                  Color(0xffb3bfaf),
                ],
              ),
            ),
            child: ElevatedButton(
              onPressed: tempSelectedIndex != null
                  ? () {
                // Save selected board
                onBoardSelected(tempSelectedIndex);
                // Close board dialog
                Navigator.pop(dialogContext);
                // Show settings dialog
                Future.delayed(
                  const Duration(milliseconds: 180),
                  _showSettingsDialog,
                );
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child:  Text(
                'Next',
                style: AppTextStyle.defaultTextStyleWhite.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }

  // STEP 2: Settings Dialog
  void _showSettingsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SettingsDialog(
          settings: settings,
          onSave: (updatedSettings) {
            onSettingsSaved(updatedSettings);
          },
        );
      },
    );
  }

  // Fallback for image loading errors
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
        child: Icon(
          icons[index % icons.length],
          size: 44,
          color: Colors.white.withOpacity(0.72),
        ),
      ),
    );
  }
}