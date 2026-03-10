import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

class PremiumBackground extends StatefulWidget {
  const PremiumBackground({super.key});

  @override
  State<PremiumBackground> createState() => _PremiumBackgroundState();
}

class _PremiumBackgroundState extends State<PremiumBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base Solid Canvas
        Container(
          color: neutralWhite,
        ),
        
        // Animated Glowing Orbs
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final sinValue = Curves.easeInOutSine.transform(_controller.value);
            return Stack(
              children: [
                Positioned(
                  top: -100 + (sinValue * 60),
                  left: -50 + (sinValue * 30),
                  child: Container(
                    width: 350,
                    height: 350,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: secondaryGreen.withOpacity(0.4),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -150 + (sinValue * -40),
                  right: -100 + (sinValue * 50),
                  child: Container(
                    width: 450,
                    height: 450,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryGreen.withOpacity(0.3),
                    ),
                  ),
                ),
                Positioned(
                  top: 300 + (sinValue * 40),
                  right: -50 + (sinValue * -20),
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: darkGreen.withOpacity(0.15),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        
        // Massive Blur Filter overlaying the Orbs to create frosted dynamic backdrop
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}
