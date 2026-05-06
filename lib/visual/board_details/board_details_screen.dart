/**

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subliminal/core/app_text_style.dart';
import '../../widget/custom_background_two.dart';

class BoardDetailScreen extends StatefulWidget {
  final Map<String, dynamic> board;

  const BoardDetailScreen({super.key, required this.board});

  @override
  State<BoardDetailScreen> createState() => _BoardDetailScreenState();
}

class _BoardDetailScreenState extends State<BoardDetailScreen> {
  bool isEditing = false;
  List<Map<String, dynamic>> cards = [];

  @override
  void initState() {
    super.initState();
    // Initialize cards with sample data
    cards = [
      {
        'name': 'Mountain View',
        'type': 'image',
        'assetPath': 'assets/images/image1.png',
      },
      {
        'name': 'Luxury Car',
        'type': 'image',
        'assetPath': 'assets/images/image1.png',
      },
      {
        'name': 'Believe in Yourself',
        'type': 'text',
        'quote': 'Believe in Yourself',
      },
      {
        'name': 'Sunset Ocean',
        'type': 'image',
        'assetPath': 'assets/images/image2.png',
      },
      {
        'name': 'Couple Beach',
        'type': 'image',
        'assetPath': 'assets/images/image3.png',
      },
      {
        'name': 'Modern House',
        'type': 'image',
        'assetPath': 'assets/images/image4.png',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CustomBackgroundTwo(),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFF8F4F0),
                        Color(0xFFF0E9E4),
                        Color(0xFFEAE4DF),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
                        child: Text(
                          widget.board['name'] ?? 'Board One', // 🔥 Board name from previous page
                          style:  TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withValues(alpha: 0.9),
                          ),
                        ),
                      ),

                      /// ZIG-ZAG LAYOUT
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: _buildAlternatingRows(),
                          ),
                        ),
                      ),

                      // const SizedBox(height: 16),

                      /// EDIT BUTTON
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: OutlinedButton(
                            onPressed: () {
                              _showEditDialog();
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 14,
                              ),
                            ),
                            child:  Text(
                              'Edit',
                              style: AppTextStyle.defaultTextStyleBlack.copyWith(
                                fontWeight: FontWeight.bold
                              )
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Show Edit Dialog with Image Settings (Matching the exact design)
  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.white,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Image Settings Title
                const Text(
                  'Image Settings',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                ),

                const SizedBox(height: 24),

                /// Container with border and dividers
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      /// Change Cover Image Button
                      _buildDialogButton(
                        icon: Icons.photo_library_outlined,
                        text: 'Change Cover Image',
                        onTap: () {
                          // Handle change cover image
                          Navigator.pop(context);
                        },
                        showDivider: true,
                      ),

                      /// Shuffle Images Button
                      _buildDialogButton(
                        icon: Icons.shuffle,
                        text: 'Shuffle Images',
                        onTap: () {
                          // Handle shuffle images
                          Navigator.pop(context);
                        },
                        showDivider: true,
                      ),

                      /// Delete Image Button (No divider after last item)
                      _buildDialogButton(
                        icon: Icons.delete_outline,
                        text: 'Delete Image',
                        onTap: () {
                          // Handle delete image
                          Navigator.pop(context);
                        },
                        textColor: const Color(0xFFE74C3C),
                        showDivider: false,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                /// Add New Image Button (Outlined style with + icon)
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF7D91AA),
                      width: 1.5,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // Handle add new image
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add,
                              color: Color(0xFF7D91AA),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Add New Image',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF7D91AA),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                /// Cancel and Save Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40), // Match this
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle save
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Changes saved successfully'),
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff7d91aa), // Fallback color
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40), // Apply directly to button
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Custom Dialog Button Widget with Divider
  Widget _buildDialogButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color textColor = const Color(0xFF2C3E50),
    required bool showDivider,
  }) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: textColor,
                    size: 22,
                  ),
                  const SizedBox(width: 14),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 0,
            thickness: 1,
            color: Colors.grey.withOpacity(0.3),
          ),
      ],
    );
  }

  /// ALTERNATING ROWS (ZIG-ZAG)
  List<Widget> _buildAlternatingRows() {
    List<Widget> rows = [];

    for (int i = 0; i < cards.length; i += 2) {
      final bool isEvenRow = (i / 2).floor() % 2 == 0;

      if (i + 1 < cards.length) {
        rows.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: isEvenRow
                  ? [
                Expanded(
                  flex: 5,
                  child: _buildCard(cards[i], aspectRatio: 0.8),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 6,
                  child: _buildCard(cards[i + 1], aspectRatio: 1.15),
                ),
              ]
                  : [
                Expanded(
                  flex: 6,
                  child: _buildCard(cards[i], aspectRatio: 1.15),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 5,
                  child: _buildCard(cards[i + 1], aspectRatio: 0.8),
                ),
              ],
            ),
          ),
        );
      } else {
        rows.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildCard(cards[i], aspectRatio: 0.9),
          ),
        );
      }
    }

    return rows;
  }

  /// CARD BUILDER
  Widget _buildCard(Map<String, dynamic> card, {required double aspectRatio}) {
    if (card['type'] == 'text') {
      return AspectRatio(
        aspectRatio: aspectRatio,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              card['quote'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                color: Color(0xFF6B6B6B),
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: aspectRatio,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                card['assetPath'],
                fit: BoxFit.cover,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(card['name'])),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}*/









import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subliminal/core/app_text_style.dart';
import 'dart:ui' as ui;
import '../../widget/custom_background_two.dart';

class BoardDetailScreen extends StatefulWidget {
  final Map<String, dynamic> board;

  const BoardDetailScreen({super.key, required this.board});

  @override
  State<BoardDetailScreen> createState() => _BoardDetailScreenState();
}

class _BoardDetailScreenState extends State<BoardDetailScreen> {
  bool isEditing = false;
  List<Map<String, dynamic>> cards = [];

  @override
  void initState() {
    super.initState();
    // Initialize cards with sample data
    cards = [
      {
        'name': 'Mountain View',
        'type': 'image',
        'assetPath': 'assets/images/image1.png',
      },
      {
        'name': 'Luxury Car',
        'type': 'image',
        'assetPath': 'assets/images/image1.png',
      },
      {
        'name': 'Believe in Yourself',
        'type': 'text',
        'quote': 'Believe in Yourself',
      },
      {
        'name': 'Sunset Ocean',
        'type': 'image',
        'assetPath': 'assets/images/image2.png',
      },
      {
        'name': 'Couple Beach',
        'type': 'image',
        'assetPath': 'assets/images/image3.png',
      },
      {
        'name': 'Modern House',
        'type': 'image',
        'assetPath': 'assets/images/image4.png',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CustomBackgroundTwo(),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withValues(alpha: 0.25),
                            Colors.white.withValues(alpha: 0.15),
                            Colors.white.withValues(alpha: 0.1),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
                            child: Text(
                              widget.board['name'] ?? 'Board One',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10,
                                    color: Colors.black26,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          /// ZIG-ZAG LAYOUT
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: _buildAlternatingRows(),
                              ),
                            ),
                          ),

                          /// EDIT BUTTON
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  _showEditDialog();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withValues(alpha: 0.9),
                                  foregroundColor: const Color(0xFF4A4A4A),
                                  elevation: 2,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 18,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                child: Text(
                                  'Edit',
                                  style: AppTextStyle.defaultTextStyleBlack.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              // child: OutlinedButton(
                              //   onPressed: () {
                              //     _showEditDialog();
                              //   },
                              //   style: OutlinedButton.styleFrom(
                              //     foregroundColor: Colors.white,
                              //     side: const BorderSide(color: Colors.white54),
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(25),
                              //     ),
                              //     padding: const EdgeInsets.symmetric(
                              //       horizontal: 40,
                              //       vertical: 14,
                              //     ),
                              //   ),
                              //   child: Text(
                              //     'Edit',
                              //     style: AppTextStyle.defaultTextStyleBlack.copyWith(
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.white,
                              //     ),
                              //   ),
                              // ),
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Show Edit Dialog with Image Settings (Matching the exact design)
  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.white,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Image Settings Title
                const Text(
                  'Image Settings',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                ),

                const SizedBox(height: 24),

                /// Container with border and dividers
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      /// Change Cover Image Button
                      _buildDialogButton(
                        icon: Icons.photo_library_outlined,
                        text: 'Change Cover Image',
                        onTap: () {
                          // Handle change cover image
                          Navigator.pop(context);
                        },
                        showDivider: true,
                      ),

                      /// Shuffle Images Button
                      _buildDialogButton(
                        icon: Icons.shuffle,
                        text: 'Shuffle Images',
                        onTap: () {
                          // Handle shuffle images
                          Navigator.pop(context);
                        },
                        showDivider: true,
                      ),

                      /// Delete Image Button (No divider after last item)
                      _buildDialogButton(
                        icon: Icons.delete_outline,
                        text: 'Delete Image',
                        onTap: () {
                          // Handle delete image
                          Navigator.pop(context);
                        },
                        textColor: const Color(0xFFE74C3C),
                        showDivider: false,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                /// Add New Image Button (Outlined style with + icon)
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF7D91AA),
                      width: 1.5,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // Handle add new image
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add,
                              color: Color(0xFF7D91AA),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Add New Image',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF7D91AA),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                /// Cancel and Save Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle save
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Changes saved successfully'),
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff7d91aa),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Custom Dialog Button Widget with Divider
  Widget _buildDialogButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color textColor = const Color(0xFF2C3E50),
    required bool showDivider,
  }) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: textColor,
                    size: 22,
                  ),
                  const SizedBox(width: 14),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 0,
            thickness: 1,
            color: Colors.grey.withOpacity(0.3),
          ),
      ],
    );
  }

  /// ALTERNATING ROWS (ZIG-ZAG)
  List<Widget> _buildAlternatingRows() {
    List<Widget> rows = [];

    for (int i = 0; i < cards.length; i += 2) {
      final bool isEvenRow = (i / 2).floor() % 2 == 0;

      if (i + 1 < cards.length) {
        rows.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: isEvenRow
                  ? [
                Expanded(
                  flex: 5,
                  child: _buildCard(cards[i], aspectRatio: 0.8),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 6,
                  child: _buildCard(cards[i + 1], aspectRatio: 1.15),
                ),
              ]
                  : [
                Expanded(
                  flex: 6,
                  child: _buildCard(cards[i], aspectRatio: 1.15),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 5,
                  child: _buildCard(cards[i + 1], aspectRatio: 0.8),
                ),
              ],
            ),
          ),
        );
      } else {
        rows.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildCard(cards[i], aspectRatio: 0.9),
          ),
        );
      }
    }

    return rows;
  }

  /// CARD BUILDER
  Widget _buildCard(Map<String, dynamic> card, {required double aspectRatio}) {
    if (card['type'] == 'text') {
      return AspectRatio(
        aspectRatio: aspectRatio,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              card['quote'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                color: Color(0xFF6B6B6B),
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: aspectRatio,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                card['assetPath'],
                fit: BoxFit.cover,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(card['name'])),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}