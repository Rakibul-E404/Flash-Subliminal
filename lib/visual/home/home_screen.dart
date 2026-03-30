import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:subliminal/core/app_text_style.dart';
import 'dart:io';
import '../../widget/custom_background_two.dart';
import 'board_details_screen.dart';

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
      'name': 'Board Three',
      'type': 'image',
      'assetPath': 'assets/images/image3.png',
      'isLocal': true,
      'imageFile': null,
    },
    {
      'name': 'Board Four',
      'type': 'image',
      'assetPath': 'assets/images/image4.png',
      'isLocal': true,
      'imageFile': null,
    }
  ];

  // Text controllers for rename mode
  List<TextEditingController> _nameControllers = [];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _nameControllers = boards.map((board) =>
        TextEditingController(text: board['name'])
    ).toList();
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
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
                        style: TextStyle(fontSize: 16, color: Color(0xFF4A4A4A)),
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
                      leading: const Icon(Icons.image, color: Color(0xFF9DB4C0)),
                      title: const Text(
                        'Change Cover Image',
                        style: TextStyle(fontSize: 16, color: Color(0xFF4A4A4A)),
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
                      leading: const Icon(Icons.delete, color: Color(0xFF9DB4C0)),
                      title: const Text(
                        'Delete Board',
                        style: TextStyle(fontSize: 16, color: Color(0xFF4A4A4A)),
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
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4A4A4A),
                  ),
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
                          colors: [
                            Color(0xff7d91aa),
                            Color(0xffb3bfaf),
                          ],
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
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
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
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF6B6B6B),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey,
            ),
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
    return Scaffold(body: Stack(
      children: [
        const CustomBackgroundTwo(),
        SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
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
                  padding: const EdgeInsets.all(28),
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

                      // Boards Grid
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: boards.length,
                        itemBuilder: (context, index) {
                          if (_currentMode == 'rename') {
                            return _buildRenameBoardItem(index);
                          } else if (_currentMode == 'changeCover') {
                            return _buildChangeCoverBoardItem(index);
                          } else if (_currentMode == 'delete') {
                            return _buildDeleteBoardItem(index);
                          } else {
                            return _buildNormalBoardItem(index);
                          }
                        },
                      ),

                      const SizedBox(height: 28),

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
                                  padding: const EdgeInsets.symmetric(vertical: 16),
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
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                  ),
                                  child: _currentMode == 'delete'
                                      ? const Text(
                                    'Done',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  )
                                      : const Text(
                                    'Save',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 8),
                                  Text(
                                    'Edit',
                                    style: AppTextStyle.defaultTextStyleBlack.copyWith(
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
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
    ),);
  }

  // Normal board item (default view)
  Widget _buildNormalBoardItem(int index) {
    final board = boards[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GestureDetector(
            // In _buildNormalBoardItem method, update the onTap:
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BoardDetailScreen(board: board),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: _buildImageContent(board),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          board['name'],
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF6B6B6B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }





  // Rename board item (with editable text fields)
  Widget _buildRenameBoardItem(int index) {
    final board = boards[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: _buildImageContent(board),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _nameControllers[index],
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B6B6B),
                  fontWeight: FontWeight.w500,
                ),
                // decoration: const InputDecoration(
                //   isDense: true,
                //   contentPadding: EdgeInsets.symmetric(vertical: 4),
                //   border: InputBorder.none,
                //   enabledBorder: UnderlineInputBorder(
                //     borderSide: BorderSide(color: Color(0xFFE0D5CF)),
                //   ),
                //   focusedBorder: UnderlineInputBorder(
                //     borderSide: BorderSide(color: Color(0xFF9DB4C0), width: 2),
                //   ),
                // ),
              ),
            ),
            const Icon(
              Icons.edit,
              size: 18,
              color: Color(0xFF9DB4C0),
            ),
          ],
        ),
      ],
    );
  }

  // Change cover image board item (with camera icon overlay)
  Widget _buildChangeCoverBoardItem(int index) {
    final board = boards[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              _pickImageFromGallery(index);
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        _buildImageContent(board),
                        // Dark overlay
                        Container(
                          color: Colors.black.withOpacity(0.4),
                        ),
                        // Camera icon
                        const Center(
                          child: Icon(
                            Icons.camera_alt,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          board['name'],
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF6B6B6B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Delete board item (with close button at top right)
  Widget _buildDeleteBoardItem(int index) {
    final board = boards[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: _buildImageContent(board),
                ),
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
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
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
                      size: 22,
                      color: Color(0xFF78909C),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          board['name'],
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF6B6B6B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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
                child: Icon(Icons.broken_image, color: Colors.grey),
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
                child: Icon(Icons.image, color: Colors.grey),
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
                child: Icon(Icons.broken_image, color: Colors.grey),
              ),
            );
          },
        );
      }
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF0EBE5),
            Color(0xFFE6DFD8),
          ],
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.camera_alt,
          size: 40,
          color: Color(0xFF8B7355),
        ),
      ),
    );
  }
}

















