import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:subliminal/widget/custom_background_two.dart';
import '../../widget/custom_background.dart';

class DedicationScreen extends StatelessWidget {
  const DedicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Stack(
        children: [
          /// 🌄 Background
          const CustomBackgroundTwo(),

          /// 📱 Content
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// 🔙 Back Button
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () => Get.back(),
                                    icon: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      child: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),

                                  const Text(
                                    'Dedication',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                            const SizedBox(width: 30),
                                ],
                              ),
                            ),



                            const SizedBox(height: 30),

                            /// ✍️ Main Text
                            const Text(
                              'For the souls who refuse mediocrity.\n'
                                  'Unwilling to settle for anything less than extraordinary.\n\n'
                                  'No matter how loud the voices shout:\n'
                                  'dim your light... settle down.\n'
                                  'Just. Stay. In. Your. Box.\n\n'
                                  'For the ones who try again, even after a thousand failures.\n'
                                  'Ten steps forward. Nine steps back.\n'
                                  'Knocked down. Only to rise again... and again.\n\n'
                                  'For the underdogs with alpha minds.\n'
                                  'The Truth Seekers.\n'
                                  'The Silent Insurgents.\n'
                                  'The Restless Hopeful.\n\n'
                                  'For hearts that stayed true and untainted.\n'
                                  'Even when met with unkindness.\n\n'
                                  'For those who search for signs, cling to hope,\n'
                                  'and choose optimism when logic says quit.\n\n'
                                  'For the ones who know they’re meant for\n'
                                  'something greater.\n'
                                  'Even when history says otherwise.\n\n'
                                  'There is a fire within that nothing can extinguish.\n'
                                  'A yearning for more.\n\n'
                                  'No matter what life throws.\n'
                                  'No matter how much time has passed.\n'
                                  'It remains.\n'
                                  'Lying dormant.\n'
                                  'Quietly waiting.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17.5,
                                height: 1.65,
                                color: Colors.black,
                              ),
                            ),

                            const SizedBox(height: 40),

                            /// Spacer pushes logo to bottom if screen has space
                            const Spacer(),

                            /// 🖼 IMAGE (replacing SVG)
                            Image.asset(
                              'assets/images/Souliminal logo 1.png',
                              height: 120,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Text(
                                  'Image not found',
                                  style: TextStyle(color: Colors.white),
                                );
                              },
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}