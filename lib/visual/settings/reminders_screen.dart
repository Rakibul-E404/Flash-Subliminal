import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/custom_background.dart';
import '../../widget/custom_gradientBorder_button.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  bool isReminderEnabled = true;
  String reminderTime = '12 : 00 AM';
  String repeat = 'Daily';
  int flashes = 25;

  // Custom Time Picker Dialog matching the image exactly
  Future<void> _showCustomTimePicker() async {
    TimeOfDay initialTime = _parseTimeString(reminderTime);

    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: _CustomTimePickerDialog(
            initialTime: initialTime,
            onTimeSelected: (TimeOfDay newTime) {
              setState(() {
                String hour = _formatNumber(newTime.hour % 12 == 0 ? 12 : newTime.hour % 12);
                String minute = _formatNumber(newTime.minute);
                String period = newTime.hour < 12 ? 'AM' : 'PM';
                reminderTime = '$hour : $minute $period';
              });
            },
          ),
        );
      },
    );
  }

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  TimeOfDay _parseTimeString(String timeString) {
    try {
      String cleanString = timeString.replaceAll(' ', '');
      final parts = cleanString.split(':');
      final minuteAndPeriod = parts[1].split(' ');
      int hour = int.parse(parts[0]);
      final minute = int.parse(minuteAndPeriod[0]);
      final period = minuteAndPeriod[1];

      if (period == 'PM' && hour != 12) {
        hour += 12;
      } else if (period == 'AM' && hour == 12) {
        hour = 0;
      }
      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      return const TimeOfDay(hour: 12, minute: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Header
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () => Get.back(),
                          icon: CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        'Reminders',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Daily Reminders',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Enable Daily Reminders
                  _buildSettingCard(
                    icon: Icons.notifications,
                    title: 'Enable Daily Reminders',
                    trailing: Switch(
                      value: isReminderEnabled,
                      onChanged: (value) {
                        setState(() => isReminderEnabled = value);
                      },
                      activeColor: Colors.white,
                      activeTrackColor: const Color(0xFF4CAF50),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Reminder Time - with custom time picker
                  _buildSettingCard(
                    icon: Icons.access_time,
                    title: 'Reminder Time',
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          reminderTime,
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.white70),
                      ],
                    ),
                    onTap: _showCustomTimePicker,
                  ),

                  const SizedBox(height: 12),

                  // Repeat
                  _buildSettingCard(
                    icon: Icons.repeat,
                    title: 'Repeat',
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          repeat,
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.white70),
                      ],
                    ),
                    onTap: _showRepeatOptions,
                  ),

                  const SizedBox(height: 24),

                  // Daily Subliminal Flashes
                  _buildSettingCard(
                    icon: Icons.bar_chart,
                    title: 'Daily Subliminal Flashes',
                    trailing: Text(
                      '$flashes',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Bottom motivational section
                  Center(
                    child: Column(
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(fontSize: 16, color: Colors.white70),
                            children: [
                              TextSpan(text: 'Change happens '),
                              TextSpan(
                                text: 'through\nrepetition and consistency',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showRepeatOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _CustomRepeatPicker(
          currentRepeat: repeat,
          onRepeatSelected: (String newRepeat) {
            setState(() {
              repeat = newRepeat;
            });
          },
        );
      },
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          leading: Icon(icon, color: Colors.white, size: 28),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          trailing: trailing,
          onTap: onTap,
        ),
      ),
    );
  }
}

// ======================================================
// CUSTOM TIME PICKER DIALOG - Matches image exactly
// ======================================================

class _CustomTimePickerDialog extends StatefulWidget {
  final TimeOfDay initialTime;
  final Function(TimeOfDay) onTimeSelected;

  const _CustomTimePickerDialog({
    required this.initialTime,
    required this.onTimeSelected,
  });

  @override
  State<_CustomTimePickerDialog> createState() => _CustomTimePickerDialogState();
}

class _CustomTimePickerDialogState extends State<_CustomTimePickerDialog> {
  late int hour;
  late int minute;
  late String period; // "AM" or "PM"

  @override
  void initState() {
    super.initState();
    int displayHour = widget.initialTime.hour % 12;
    if (displayHour == 0) displayHour = 12;
    hour = displayHour;
    minute = widget.initialTime.minute;
    period = widget.initialTime.hour < 12 ? 'AM' : 'PM';
  }

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  void _incrementHour() {
    setState(() {
      hour++;
      if (hour > 12) hour = 1;
    });
  }

  void _decrementHour() {
    setState(() {
      hour--;
      if (hour < 1) hour = 12;
    });
  }

  void _incrementMinute() {
    setState(() {
      minute++;
      if (minute > 59) minute = 0;
    });
  }

  void _decrementMinute() {
    setState(() {
      minute--;
      if (minute < 0) minute = 59;
    });
  }

  void _incrementPeriod() {
    setState(() {
      period = period == 'AM' ? 'PM' : 'AM';
    });
  }

  void _decrementPeriod() {
    setState(() {
      period = period == 'AM' ? 'PM' : 'AM';
    });
  }

  TimeOfDay _getSelectedTime() {
    int militaryHour;
    if (period == 'AM') {
      militaryHour = hour == 12 ? 0 : hour;
    } else {
      militaryHour = hour == 12 ? 12 : hour + 12;
    }
    return TimeOfDay(hour: militaryHour, minute: minute);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F1ED),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          const Text(
            'Reminder Time',
            style: TextStyle(
              color: Color(0xFF2C3E50),
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 24),

          // Time display with up/down buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Hour column
              _buildTimeColumn(
                value: _formatNumber(hour),
                onIncrement: _incrementHour,
                onDecrement: _decrementHour,
              ),

              // Colon
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  ':',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ),

              // Minute column
              _buildTimeColumn(
                value: _formatNumber(minute),
                onIncrement: _incrementMinute,
                onDecrement: _decrementMinute,
              ),

              const SizedBox(width: 12),

              // AM/PM column
              _buildTimeColumn(
                value: period,
                onIncrement: _incrementPeriod,
                onDecrement: _decrementPeriod,
                isPeriod: true,
              ),
            ],
          ),

          const SizedBox(height: 28),

          // Cancel and Save buttons
          Row(
            children: [
              // Cancel button (simple outlined style)
              Expanded(
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(0xFFB3BFAF).withOpacity(0.6),
                      width: 1.5,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xFF2C3E50),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Save button using GradientBorderButton
              Expanded(
                child: GradientBorderButton(
                  text: 'Save',
                  height: 56,
                  onTap: () {
                    widget.onTimeSelected(_getSelectedTime());
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeColumn({
    required String value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
    bool isPeriod = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Up button - CIRCULAR
        InkWell(
          onTap: onIncrement,
          borderRadius: BorderRadius.circular(22),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.keyboard_arrow_up,
              color: const Color(0xFF2C3E50),
              size: 28,
            ),
          ),
        ),

        // Time value
        Container(
          width: isPeriod ? 60 : 64,
          height: 60,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            value,
            style: TextStyle(
              fontSize: isPeriod ? 24 : 32,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2C3E50),
            ),
          ),
        ),

        // Down button - CIRCULAR
        InkWell(
          onTap: onDecrement,
          borderRadius: BorderRadius.circular(22),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: const Color(0xFF2C3E50),
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}

// ======================================================
// CUSTOM REPEAT PICKER
// ======================================================

class _CustomRepeatPicker extends StatefulWidget {
  final String currentRepeat;
  final Function(String) onRepeatSelected;

  const _CustomRepeatPicker({
    required this.currentRepeat,
    required this.onRepeatSelected,
  });

  @override
  State<_CustomRepeatPicker> createState() => _CustomRepeatPickerState();
}

class _CustomRepeatPickerState extends State<_CustomRepeatPicker> {
  late String selectedRepeat;

  final List<String> repeatOptions = [
    'Daily',
    'Weekdays',
    'Weekends',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  void initState() {
    super.initState();
    selectedRepeat = widget.currentRepeat;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A2E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                ),
                const Text(
                  'Repeat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onRepeatSelected(selectedRepeat);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Color(0xFF4CAF50),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Options list
          Expanded(
            child: ListView.builder(
              itemCount: repeatOptions.length,
              itemBuilder: (context, index) {
                final option = repeatOptions[index];
                final isSelected = selectedRepeat == option;

                return ListTile(
                  title: Text(
                    option,
                    style: TextStyle(
                      fontSize: 18,
                      color: isSelected ? const Color(0xFF4CAF50) : Colors.white,
                      fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: Color(0xFF4CAF50))
                      : null,
                  onTap: () {
                    setState(() {
                      selectedRepeat = option;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}