import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../widget/custom_background.dart';   // Make sure the path is correct

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  bool isReminderEnabled = true;
  String reminderTime = '9:00 AM';
  String repeat = 'Daily';
  int flashes = 25;

  // Time Picker
  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );

    if (picked != null) {
      setState(() {
        reminderTime = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent, // Important: Keep background transparent
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
                            backgroundColor: Colors.grey,
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

                  // Reminder Time
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
                    onTap: _pickTime,
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
                    onTap: () {
                      // TODO: Add repeat selection dialog later
                    },
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