import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../widget/custom_background_two.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isEditMode = false;
  final ImagePicker _picker = ImagePicker();

  // Track which boards are selected for editing
  List<bool> _selectedBoards = List.generate(4, (index) => false);

  // Board data
  List<Map<String, dynamic>> boards = [
    {
      'name': 'Board One',
      'type': 'image',
      'assetPath': 'assets/images/image1.png',
      'isLocal': true,
      'imageFile': null, // For storing picked images
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

  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
      if (!_isEditMode) {
        // Reset selections when exiting edit mode
        _selectedBoards = List.generate(4, (index) => false);
      }
    });
  }

  void _toggleBoardSelection(int index) {
    setState(() {
      _selectedBoards[index] = !_selectedBoards[index];
    });
  }

  void _cancelEdit() {
    setState(() {
      _isEditMode = false;
      _selectedBoards = List.generate(4, (index) => false);
    });
  }

  void _saveChanges() {
    // Here you can save the selected boards or perform any edit operations
    List<String> selectedBoardNames = [];
    for (int i = 0; i < _selectedBoards.length; i++) {
      if (_selectedBoards[i]) {
        selectedBoardNames.add(boards[i]['name']);
      }
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Changes Saved',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A4A4A),
          ),
        ),
        content: selectedBoardNames.isEmpty
            ? const Text(
          'No changes were made.',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF6B6B6B),
          ),
        )
            : Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Updated boards:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4A4A4A),
              ),
            ),
            const SizedBox(height: 8),
            ...selectedBoardNames.map((name) => Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 4),
              child: Text(
                '• $name',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B6B6B),
                ),
              ),
            )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _cancelEdit();
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF9DB4C0),
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Function to pick image from gallery
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

  // Function to remove image
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
          'Are you sure you want to remove this board?',
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
                // Reset to default placeholder or remove image
                boards[index]['type'] = 'image';
                boards[index]['imageFile'] = null;
                boards[index]['assetPath'] = 'assets/images/placeholder.png';
                boards[index]['isLocal'] = true;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Image removed!'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9DB4C0),
              foregroundColor: Colors.white,
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Custom Background
        const CustomBackgroundTwo(),

        // Main Content
        SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFF8F4F0),
                      const Color(0xFFF0E9E4),
                      const Color(0xFFEAE4DF),
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
                      // Title with Edit Mode Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'My Boards',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4A4A4A),
                            ),
                          ),
                          if (_isEditMode)
                            Container(
                              margin: const EdgeInsets.only(left: 12),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF9DB4C0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Edit Mode',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Boards Grid (2x2)
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return _buildBoardItem(index);
                        },
                      ),
                      const SizedBox(height: 28),

                      // Buttons Section
                      if (_isEditMode)
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _cancelEdit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withValues(alpha: 0.5),
                                  foregroundColor: Colors.black,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 18,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    side: const BorderSide(
                                        color: Colors.grey,
                                        width: 1
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
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
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF9DB4C0).withValues(alpha: 0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: _saveChanges,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 18,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: const Text(
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
                            width: 200,
                            child: ElevatedButton(
                              onPressed: _toggleEditMode,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF9DB4C0),
                                foregroundColor: Colors.white,
                                elevation: 2,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.edit, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
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
    );
  }

  Widget _buildBoardItem(int index) {
    final board = boards[index];
    final isSelected = _selectedBoards[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Board Image/Card
        Expanded(
          child: Stack(
            children: [
              // Image Container with Tap to select/gallery
              GestureDetector(
                onTap: () {
                  if (_isEditMode) {
                    // In edit mode, show gallery option
                    _showImageOptionsDialog(index);
                  } else {
                    // In normal mode, just select the board
                    _toggleBoardSelection(index);
                  }
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

              // Remove Button (Cross) - Only visible in edit mode
              if (_isEditMode)
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => _deleteBoard(index),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),

              // Selection Overlay in Edit Mode
              if (_isEditMode && isSelected)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFF9DB4C0).withValues(alpha: 0.6),
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Board Name with Edit Icon - ONLY visible in Edit Mode
        Row(
          children: [
            Expanded(
              child: Text(
                board['name'],
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B6B6B),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Edit icon ONLY visible when in edit mode
            if (_isEditMode)
              GestureDetector(
                onTap: () {
                  _showEditBoardDialog(index);
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF9DB4C0).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.edit,
                    size: 16,
                    color: Color(0xFF9DB4C0),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  // Helper method to build image content
  Widget _buildImageContent(Map<String, dynamic> board) {
    if (board['type'] == 'image') {
      if (board['imageFile'] != null) {
        // Display picked image from gallery
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
        // Display asset image
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
        // Display file image
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

    // Fallback container
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
          Icons.add_photo_alternate,
          size: 40,
          color: Color(0xFF8B7355),
        ),
      ),
    );
  }

  // Show image options dialog (Gallery/Camera)
  void _showImageOptionsDialog(int index) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Choose Image',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFF9DB4C0)),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery(index);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera, color: Color(0xFF9DB4C0)),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto(index);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  // Function to take photo with camera
  Future<void> _takePhoto(int index) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
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
            content: Text('Photo captured successfully!'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error taking photo: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _showEditBoardDialog(int index) {
    final TextEditingController controller = TextEditingController(text: boards[index]['name']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Edit Board Name',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A4A4A),
          ),
        ),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter board name',
            border: OutlineInputBorder(),
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
                boards[index]['name'] = controller.text;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Board name updated!'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9DB4C0),
              foregroundColor: Colors.white,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}