import 'package:flutter/material.dart';
import '../../widget/custom_background.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool isInfiniteSelected = true; // Default: Infinite plan selected

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // Header with Back Button
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Subscription',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // Balance spacing
                  ],
                ),

                const SizedBox(height: 20),

                // Subtitle
                const Text(
                  'Unlock the power of your subconscious',
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                // Plans
                GestureDetector(
                  onTap: () => setState(() => isInfiniteSelected = false),
                  child: _buildPlanCard(
                    title: 'Soulminal Mind Upgrade',
                    price: '\$9.99/month',
                    isSelected: !isInfiniteSelected,
                  ),
                ),

                const SizedBox(height: 16),

                GestureDetector(
                  onTap: () => setState(() => isInfiniteSelected = true),
                  child: _buildPlanCard(
                    title: 'Soulminal Infinite',
                    price: '\$59.99/ year (Save 50%)',
                    subPrice: 'Only \$4.99/ month',
                    isSelected: isInfiniteSelected,
                    isRecommended: true,
                  ),
                ),

                const Spacer(),

                // Subscribe Button
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      // BORDER gradient (bottom to top)
                      gradient: const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Color(0xff7d91aa), Color(0xffb3bfaf)],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.all(2), // Border width
                    child: Container(
                      // YOUR ORIGINAL gradient background (topLeft to bottomRight)
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xff7d91aa), Color(0xffb3bfaf)],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: SizedBox(
                        width: 250,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'Subscribe',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Footer Text
                const Center(
                  child: Text(
                    '7 days free, then billed at \$9.99/month. Cancel anytime.',
                    style: TextStyle(fontSize: 14, color: Colors.white60),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    String? subPrice,
    bool isSelected = false,
    bool isRecommended = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(isSelected ? 0.5 : 0.12),
        borderRadius: BorderRadius.circular(20),
        border: isSelected
            ? Border.all(color: Colors.white.withOpacity(0.6), width: 2)
            : null,
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.white.withOpacity(0.15),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isRecommended)
            const Align(
              alignment: Alignment.topRight,
              child: Text(
                'BEST VALUE',
                style: TextStyle(
                  color: Color(0xFF4CAF50),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          if (subPrice != null) ...[
            const SizedBox(height: 4),
            Text(
              subPrice,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF4CAF50),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
