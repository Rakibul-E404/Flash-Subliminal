

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/settings_model.dart';

class SettingsDialog extends StatefulWidget {
  final SettingsModel settings;
  final Function(SettingsModel) onSave;

  const SettingsDialog({
    super.key,
    required this.settings,
    required this.onSave,
  });

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  late SettingsModel _tempSettings;

  @override
  void initState() {
    super.initState();
    _tempSettings = widget.settings;
  }

  @override
  Widget build(BuildContext context) {
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
              ['Centre', 'Random'],
              _tempSettings.position,
                  (value) {
                setState(() {
                  _tempSettings = _tempSettings.copyWith(position: value);
                });
              },
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
              ['300 ms', '1 s', '3 s', '5s'],
              _tempSettings.showEvery,
                  (value) {
                setState(() {
                  _tempSettings = _tempSettings.copyWith(showEvery: value);
                });
              },
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
              ['Small', 'Full'],
              _tempSettings.imageSize,
                  (value) {
                setState(() {
                  _tempSettings = _tempSettings.copyWith(imageSize: value);
                });
              },
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
              ['30 m', '40 m', '60 m', 'Auto'],
              _tempSettings.sessionLength,
                  (value) {
                setState(() {
                  _tempSettings = _tempSettings.copyWith(sessionLength: value);
                });
              },
            ),
            if (_tempSettings.sessionLength == 'Auto')
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
              ['Off', 'Frequency', 'Subliminal'],
              _tempSettings.audioOptions,
                  (value) {
                setState(() {
                  _tempSettings = _tempSettings.copyWith(audioOptions: value);
                });
              },
            ),
            // const SizedBox(height: 12),
            // if (_tempSettings.audioOptions == 'Frequency')
            //   const Text(
            //     '• Frequency: pure sound frequencies only',
            //     style: TextStyle(fontSize: 12, color: Colors.grey),
            //   ),
            // if (_tempSettings.audioOptions == 'Subliminal')
            //   Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Text(
            //         '• Frequency: pure sound frequencies only',
            //         style: TextStyle(fontSize: 12, color: Colors.grey),
            //       ),
            //       const Text(
            //         '• Subliminal: affirmations embedded in audio',
            //         style: TextStyle(fontSize: 12, color: Colors.grey),
            //       ),
            //     ],
            //   ),


            const SizedBox(height: 32),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
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
                      onPressed: () {
                        widget.onSave(_tempSettings);
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Settings saved!'),
                            backgroundColor: Color(0xFFB8D4D3),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
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
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentedControl(
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
              onTap: () => onSelected(option),
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