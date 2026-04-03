import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:subliminal/core/app_text_style.dart';
import 'dart:io';
import '../../widget/custom_background_two.dart';
import '../board_details/board_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();

  // Mode tracking: 'normal', 'rename', 'changeCover', 'delete'
  String _currentMode = 'normal';

  // Board data
  List<Map<String, dynamic>> boards = [
    {
      'name': 'Board One',
      'type': 'image',
      'assetPath': 'assets/images/image1.png',
      'isLocal': true,
      'imageFile': null,
    },
    {
      'name': 'Board Two',
      'type': 'image',
      'assetPath': 'assets/images/image2.png',
      'isLocal': true,
      'imageFile': null,
    },
    {
      'name': 'Believe in Yourself',
      'type': 'image',
      'assetPath': 'assets/images/image3.png',
      'isLocal': true,
      'imageFile': null,
    },
    {
      'name': 'Board Three',
      'type': 'image',
      'assetPath': 'assets/images/image4.png',
      'isLocal': true,
      'imageFile': null,
    },
    {
      'name': 'Board Four',
      'type': 'image',
      'assetPath': 'assets/images/image1.png',
      'isLocal': true,
      'imageFile': null,
    },
    {
      'name': 'Board Five',
      'type': 'image',
      'assetPath': 'assets/images/image2.png',
      'isLocal': true,
      'imageFile': null,
    },
  ];

  // Text controllers for rename mode
  List<TextEditingController> _nameControllers = [];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _nameControllers = boards
        .map((board) => TextEditingController(text: board['name']))
        .toList();
  }

  @override
  void dispose() {
    for (var controller in _nameControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Show Board Settings Dialog
  void _showBoardSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Board Settings',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
              ),

              const Divider(height: 1),

              // Options List
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.edit, color: Color(0xFF9DB4C0)),
                      title: const Text(
                        'Rename Board',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF4A4A4A),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _currentMode = 'rename';
                          _initializeControllers();
                        });
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(
                        Icons.image,
                        color: Color(0xFF9DB4C0),
                      ),
                      title: const Text(
                        'Change Cover Image',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF4A4A4A),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _currentMode = 'changeCover';
                        });
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(
                        Icons.delete,
                        color: Color(0xFF9DB4C0),
                      ),
                      title: const Text(
                        'Delete Board',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF4A4A4A),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _currentMode = 'delete';
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Add New Board Button
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _addNewBoard();
                },
                icon: const Icon(Icons.add, color: Color(0xFF9DB4C0)),
                label: const Text(
                  'Add New Board',
                  style: TextStyle(fontSize: 16, color: Color(0xFF4A4A4A)),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF9DB4C0), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Cancel and Save Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _cancelMode();
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
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
                        onPressed: () {
                          Navigator.pop(context);
                          _saveModeChanges();
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
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void _cancelMode() {
    setState(() {
      _currentMode = 'normal';
    });
  }

  void _saveModeChanges() {
    if (_currentMode == 'rename') {
      setState(() {
        for (int i = 0; i < boards.length; i++) {
          boards[i]['name'] = _nameControllers[i].text;
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Board names updated successfully!'),
          backgroundColor: Color(0xFF9DB4C0),
        ),
      );
    }

    setState(() {
      _currentMode = 'normal';
    });
  }

  // Add New Board
  void _addNewBoard() {
    setState(() {
      boards.add({
        'name': 'New Board',
        'type': 'image',
        'isLocal': true,
        'imageFile': null,
      });
      _initializeControllers();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('New board added!'),
        backgroundColor: Color(0xFF9DB4C0),
      ),
    );
  }

  // Delete board with confirmation
  void _deleteBoard(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Delete Board',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A4A4A),
          ),
        ),
        content: const Text(
          'Are you sure you want to delete this board?',
          style: TextStyle(fontSize: 16, color: Color(0xFF6B6B6B)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(foregroundColor: Colors.grey),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                boards.removeAt(index);
                if (boards.isEmpty) {
                  boards.add({
                    'name': 'New Board',
                    'type': 'image',
                    'assetPath': 'assets/images/placeholder.png',
                    'isLocal': true,
                    'imageFile': null,
                  });
                }
                _initializeControllers();
              });
              Navigator.pop(context);

              // If no boards left, exit delete mode
              if (boards.isEmpty) {
                setState(() {
                  _currentMode = 'normal';
                });
              }

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Board deleted successfully!'),
                  backgroundColor: Color(0xFF9DB4C0),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE57373),
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImageFromGallery(int index) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          boards[index]['type'] = 'image';
          boards[index]['imageFile'] = File(pickedFile.path);
          boards[index]['assetPath'] = pickedFile.path;
          boards[index]['isLocal'] = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image updated successfully!'),
            duration: Duration(seconds: 1),
            backgroundColor: Color(0xFF9DB4C0),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
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
                // padding: const EdgeInsets.all(24.0),
                padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 80.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFF8F4F0),
                        Color(0xFFF0E9E4),
                        Color(0xFFEAE4DF),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'My Boards',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4A4A4A),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Zig-Zag Layout with same height, different widths
                        _buildZigZagGrid(),

                        // Mode-specific buttons
                        if (_currentMode != 'normal')
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: _cancelMode,
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    side: const BorderSide(color: Colors.grey),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                  ),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(fontSize: 18),
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
                                    onPressed: _saveModeChanges,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                    ),
                                    child: _currentMode == 'delete'
                                        ? const Text(
                                            'Done',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        : const Text(
                                            'Save',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        else
                          Center(
                            child: SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                onPressed: _showBoardSettingsDialog,
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
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
                                  style: AppTextStyle.defaultTextStyleBlack
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          ),
                      ],
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

  // Build Zig-Zag Grid with same height, alternating widths
  Widget _buildZigZagGrid() {
    List<Widget> rows = [];
    int itemsPerRow = 2;

    for (int i = 0; i < boards.length; i += itemsPerRow) {
      int rowIndex = i ~/ itemsPerRow;
      bool isEvenRow = rowIndex % 2 == 0;

      // Get items for this row (up to 2 items)
      List<Map<String, dynamic>> rowItems = [];
      for (int j = 0; j < itemsPerRow && i + j < boards.length; j++) {
        rowItems.add(boards[i + j]);
      }

      rows.add(_buildZigZagRow(rowItems, isEvenRow, i));
    }

    return Column(children: rows);
  }

  // Build individual row with zig-zag pattern (same height, different widths)
  Widget _buildZigZagRow(
    List<Map<String, dynamic>> rowItems,
    bool isEvenRow,
    int startIndex,
  ) {
    // Fixed height for all items
    const double itemHeight = 180;

    if (rowItems.length == 1) {
      // Single item - full width
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: SizedBox(
          height: itemHeight,
          child: Row(
            children: [
              Expanded(child: _buildBoardItem(rowItems[0], startIndex)),
            ],
          ),
        ),
      );
    }

    // For even rows: left is wider (flex 6), right is narrower (flex 4)
    // For odd rows: left is narrower (flex 4), right is wider (flex 6)
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        height: itemHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left item
            Expanded(
              flex: isEvenRow ? 6 : 4,
              child: _buildBoardItem(rowItems[0], startIndex),
            ),
            const SizedBox(width: 16),
            // Right item
            Expanded(
              flex: isEvenRow ? 4 : 6,
              child: _buildBoardItem(rowItems[1], startIndex + 1),
            ),
          ],
        ),
      ),
    );
  }

  // Build individual board item based on current mode
  Widget _buildBoardItem(Map<String, dynamic> board, int index) {
    if (_currentMode == 'rename') {
      return _buildRenameBoardItem(board, index);
    } else if (_currentMode == 'changeCover') {
      return _buildChangeCoverBoardItem(board, index);
    } else if (_currentMode == 'delete') {
      return _buildDeleteBoardItem(board, index);
    } else {
      return _buildNormalBoardItem(board, index);
    }
  }

  // Normal board item
  Widget _buildNormalBoardItem(Map<String, dynamic> board, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BoardDetailScreen(board: board),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _buildImageContent(board),
              ),
            ),
            const SizedBox(height: 8),
            // Board Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                board['name'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A4A4A),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  // Rename board item
  Widget _buildRenameBoardItem(Map<String, dynamic> board, int index) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _buildImageContent(board),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _nameControllers[index],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4A4A4A),
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 4,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE0D5CF)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE0D5CF)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF9DB4C0),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const Icon(Icons.edit, size: 18, color: Color(0xFF9DB4C0)),
            ],
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  // Change cover board item
  Widget _buildChangeCoverBoardItem(Map<String, dynamic> board, int index) {
    return GestureDetector(
      onTap: () {
        _pickImageFromGallery(index);
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildImageContent(board),
                    Container(color: Colors.black.withOpacity(0.4)),
                    const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.camera_alt, size: 40, color: Colors.white),
                          SizedBox(height: 8),
                          Text(
                            'Change Cover',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                board['name'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A4A4A),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  // Delete board item
  Widget _buildDeleteBoardItem(Map<String, dynamic> board, int index) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: _buildImageContent(board),
                ),
                // Close button at top right
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      _deleteBoard(index);
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: Color(0xFFE57373),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              board['name'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4A4A4A),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildImageContent(Map<String, dynamic> board) {
    if (board['type'] == 'image') {
      if (board['imageFile'] != null) {
        return Image.file(
          board['imageFile'],
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFE8DCD6),
              child: const Center(
                child: Icon(Icons.broken_image, size: 32, color: Colors.grey),
              ),
            );
          },
        );
      } else if (board['assetPath'] != null && board['isLocal'] == true) {
        return Image.asset(
          board['assetPath'],
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFE8DCD6),
              child: const Center(
                child: Icon(Icons.image, size: 32, color: Colors.grey),
              ),
            );
          },
        );
      } else if (board['assetPath'] != null && board['isLocal'] == false) {
        return Image.file(
          File(board['assetPath']),
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFE8DCD6),
              child: const Center(
                child: Icon(Icons.broken_image, size: 32, color: Colors.grey),
              ),
            );
          },
        );
      }
    }

    // Default placeholder for boards without images
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF0EBE5), Color(0xFFE6DFD8)],
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.photo_library, size: 40, color: Color(0xFF8B7355)),
            SizedBox(height: 8),
            Text(
              'No Image',
              style: TextStyle(fontSize: 12, color: Color(0xFF8B7355)),
            ),
          ],
        ),
      ),
    );
  }
}
