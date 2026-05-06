import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:system_alert_window/system_alert_window.dart';
import '../../core/app_background_service.dart';
import '../../models/settings_model.dart';

// ==================== FLASH OVERLAY WIDGET ====================
// Runs inside the overlay isolate spawned by system_alert_window.
// The window stays open the entire session — we just show/hide the image.
class FlashOverlayWidget extends StatefulWidget {
  const FlashOverlayWidget({super.key});

  @override
  State<FlashOverlayWidget> createState() => _FlashOverlayWidgetState();
}

class _FlashOverlayWidgetState extends State<FlashOverlayWidget> {
  bool _showImage = false;
  Timer? _flashTimer;
  Timer? _sessionTimer;

  // Settings with defaults
  String _position      = 'Centre';
  String _showEvery     = '3 s';
  String _imageSize     = 'Small';
  String _sessionLength = 'Auto';

  // List of asset image paths to cycle through
  final List<String> _imagePaths = [
    'assets/images/image1.png',
  ];
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _listenForMessages();
  }

  void _listenForMessages() {
    // The plugin sends messages via sendMessageToOverlay → overlayListener
    SystemAlertWindow.overlayListener.listen((message) {
      if (message == null) return;

      if (message is Map) {
        _position      = (message['position']      as String?) ?? 'Centre';
        _showEvery     = (message['showEvery']     as String?) ?? '3 s';
        _imageSize     = (message['imageSize']     as String?) ?? 'Small';
        _sessionLength = (message['sessionLength'] as String?) ?? 'Auto';
        _startFlashSession();
      } else if (message == 'stop') {
        _stopFlashSession();
      }
    });
  }

  void _startFlashSession() {
    _flashTimer?.cancel();
    _sessionTimer?.cancel();

    final Duration interval   = _parseDuration(_showEvery);
    final int     sessionSecs = _parseSessionLength(_sessionLength);

    // Show first flash immediately
    _triggerFlash();

    _flashTimer = Timer.periodic(interval, (_) => _triggerFlash());

    if (sessionSecs > 0) {
      _sessionTimer = Timer(Duration(seconds: sessionSecs), _stopFlashSession);
    }
  }

  void _triggerFlash() {
    if (!mounted) return;
    // Cycle through images
    setState(() {
      _showImage = true;
      _currentImageIndex = (_currentImageIndex + 1) % _imagePaths.length;
    });
    // Hide after 300 ms — window stays open, just image disappears
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _showImage = false);
    });
  }

  void _stopFlashSession() {
    _flashTimer?.cancel();
    _sessionTimer?.cancel();
    if (mounted) setState(() => _showImage = false);
    // Close the overlay window
    SystemAlertWindow.closeSystemWindow(prefMode: SystemWindowPrefMode.OVERLAY);
  }

  Duration _parseDuration(String v) {
    switch (v) {
      case '300 ms': return const Duration(milliseconds: 300);
      case '1 s':   return const Duration(seconds: 1);
      case '3 s':   return const Duration(seconds: 3);
      case '5s':    return const Duration(seconds: 5);
      default:      return const Duration(seconds: 3);
    }
  }

  int _parseSessionLength(String v) {
    switch (v) {
      case '30 m': return 30 * 60;
      case '40 m': return 40 * 60;
      case '60 m': return 60 * 60;
      default:     return 0; // Auto = run until stopped
    }
  }

  @override
  void dispose() {
    _flashTimer?.cancel();
    _sessionTimer?.cancel();
    super.dispose();
  }

  // ---- Position helpers ----
  Alignment _getAlignment() {
    if (_position == 'Random') {
      final ms = DateTime.now().millisecondsSinceEpoch;
      // Keep random position inside safe bounds (-0.7 to 0.7)
      final x = ((ms % 140) - 70) / 100.0;
      final y = (((ms ~/ 140) % 140) - 70) / 100.0;
      return Alignment(x, y);
    }
    return Alignment.center;
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = _imageSize == 'Small';
    final double w = isSmall ? size.width * 0.35 : size.width;
    final double h = isSmall ? size.width * 0.35 : size.height;
    final double r = isSmall ? 20.0 : 0.0;

    return IgnorePointer(          // ✅ entire overlay ignores all touches
      ignoring: true,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            if (_showImage)
              Container(color: Colors.black.withOpacity(0.35)),
            if (_showImage)
              Align(
                alignment: _getAlignment(),
                child: AnimatedOpacity(
                  opacity: _showImage ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 150),
                  child: Container(
                    width: w,
                    height: h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.6),
                          blurRadius: 24,
                          spreadRadius: 6,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(r),
                      child: Image.asset(
                        _imagePaths[_currentImageIndex],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.white,
                          child: const Center(
                            child: Icon(Icons.flash_on, size: 80, color: Colors.yellow),
                          ),
                        ),
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

// ==================== SETTINGS DIALOG ====================
class SettingsDialogSystem extends StatefulWidget {
  final SettingsModel settings;
  final Function(SettingsModel) onSave;

  const SettingsDialogSystem({
    super.key,
    required this.settings,
    required this.onSave,
  });

  @override
  State<SettingsDialogSystem> createState() => _SettingsDialogSystemState();
}

class _SettingsDialogSystemState extends State<SettingsDialogSystem> {
  late SettingsModel _tempSettings;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tempSettings = widget.settings;
    // Request permission early
    SystemAlertWindow.requestPermissions(prefMode: SystemWindowPrefMode.OVERLAY);
  }

// Inside _SettingsDialogSystemState:
  Future<void> _startFlashSession() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      // 1. Ensure permission
      await SystemAlertWindow.requestPermissions(
        prefMode: SystemWindowPrefMode.OVERLAY,
      );

      // // 2. Show overlay window (spawns overlayMain isolate)
      // await SystemAlertWindow.showSystemWindow(
      //   height: MediaQuery.of(context).size.height.floor(),
      //   width: MediaQuery.of(context).size.width.floor(),
      //   gravity: SystemWindowGravity.CENTER,
      //   prefMode: SystemWindowPrefMode.OVERLAY,
      //   layoutParamFlags: [SystemWindowFlags.FLAG_NOT_FOCUSABLE],
      // );

      await SystemAlertWindow.showSystemWindow(
        height: MediaQuery.of(context).size.height.floor(),
        width: MediaQuery.of(context).size.width.floor(),
        gravity: SystemWindowGravity.CENTER,
        prefMode: SystemWindowPrefMode.OVERLAY,
        layoutParamFlags: [
          SystemWindowFlags.FLAG_NOT_FOCUSABLE,  // don't steal keyboard
          SystemWindowFlags.FLAG_NOT_TOUCHABLE,  // ✅ let all touches pass through
        ],
      );


      // 3. Wait for overlay isolate to boot
      await Future.delayed(const Duration(milliseconds: 300));

      // 4. Send settings to overlay → it starts flashing independently
      await SystemAlertWindow.sendMessageToOverlay({
        'position':      _tempSettings.position,
        'showEvery':     _tempSettings.showEvery,
        'imageSize':     _tempSettings.imageSize,
        'sessionLength': _tempSettings.sessionLength,
      });

      // 5. Save settings
      widget.onSave(_tempSettings);

      // 6. Close the dialog
      if (mounted) Navigator.of(context).pop();

      // 7. ✅ Send app to background — overlay keeps flashing on top
      await Future.delayed(const Duration(milliseconds: 200));
      await AppBackground.moveToBackground();

    } catch (e) {
      debugPrint('Overlay error: $e');
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to start: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFF5F0EC),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSettingsContent(),
            const SizedBox(height: 32),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSettingItem(
          'Position', ['Centre', 'Random'], _tempSettings.position,
              (v) => setState(() => _tempSettings = _tempSettings.copyWith(position: v)),
        ),
        const SizedBox(height: 24),
        _buildSettingItem(
          'Show Every', ['300 ms', '1 s', '3 s', '5s'], _tempSettings.showEvery,
              (v) => setState(() => _tempSettings = _tempSettings.copyWith(showEvery: v)),
        ),
        const SizedBox(height: 24),
        _buildSettingItem(
          'Image Size', ['Small', 'Full'], _tempSettings.imageSize,
              (v) => setState(() => _tempSettings = _tempSettings.copyWith(imageSize: v)),
        ),
        const SizedBox(height: 24),
        _buildSettingItem(
          'Session Length', ['30 m', '40 m', '60 m', 'Auto'], _tempSettings.sessionLength,
              (v) => setState(() => _tempSettings = _tempSettings.copyWith(sessionLength: v)),
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
        _buildSettingItem(
          'Audio Options', ['Off', 'Frequency', 'Subliminal'], _tempSettings.audioOptions,
              (v) => setState(() => _tempSettings = _tempSettings.copyWith(audioOptions: v)),
        ),
      ],
    );
  }

  Widget _buildSettingItem(
      String title,
      List<String> options,
      String selectedValue,
      Function(String) onSelected,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 12),
        _buildSegmentedControl(options, selectedValue, onSelected),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              elevation: 2,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
            child:
            const Text('Cancel', style: TextStyle(fontSize: 16)),
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
                colors: [Color(0xff7d91aa), Color(0xffb3bfaf)],
              ),
            ),
            child: ElevatedButton(
              onPressed: _isLoading ? null : _startFlashSession,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: _isLoading
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
                  : const Text('Start Flash',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
            ),
          ),
        ),
      ],
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
          final idx      = entry.key;
          final option   = entry.value;
          final isSelected = selectedValue == option;
          final isLast   = idx == options.length - 1;

          return Expanded(
            child: GestureDetector(
              onTap: () => onSelected(option),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFB8D4D3)
                      : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft:     Radius.circular(idx == 0 ? 25 : 0),
                    bottomLeft:  Radius.circular(idx == 0 ? 25 : 0),
                    topRight:    Radius.circular(isLast ? 25 : 0),
                    bottomRight: Radius.circular(isLast ? 25 : 0),
                  ),
                ),
                child: Center(
                  child: Text(
                    option,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
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