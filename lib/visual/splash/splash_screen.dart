import 'package:flutter/material.dart';
import 'package:subliminal/auth/sign_up_screen.dart';
import 'package:video_player/video_player.dart';
import '../free_trial_info/free_trial_info_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  VideoPlayerController? _controller;
  bool _isVideoInitialized = false;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      // Load video from assets
      _controller = VideoPlayerController.asset('assets/videos/splash_video.mp4');

      await _controller!.initialize();

      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });

        // Play the video
        await _controller!.play();
        _controller!.setLooping(false);

        // Listen for video completion
        _controller!.addListener(() {
          if (_controller!.value.position >= _controller!.value.duration) {
            if (mounted) {
              _navigateToNextScreen();
            }
          }
        });

        // Fallback navigation after 4 seconds
        Future.delayed(const Duration(seconds: 4), () {
          if (mounted) {
            _navigateToNextScreen();
          }
        });
      }
    } catch (e) {
      print('Error loading video: $e');
      if (mounted) {
        setState(() {
          _isError = true;
        });
        // Navigate after 2 seconds if video fails
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            _navigateToNextScreen();
          }
        });
      }
    }
  }

  void _navigateToNextScreen() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          // builder: (context) => const FreeTrialInfoScreen(),
          builder: (context) => const SignUpScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: _isError
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 60,
              ),
              const SizedBox(height: 16),
              const Text(
                'Unable to load video',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _navigateToNextScreen,
                child: const Text('Continue'),
              ),
            ],
          ),
        )
            : _isVideoInitialized && _controller != null
            ? SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover, // This makes the video cover full screen
            child: SizedBox(
              width: _controller!.value.size.width,
              height: _controller!.value.size.height,
              child: VideoPlayer(_controller!),
            ),
          ),
        )
            : const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}