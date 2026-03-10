import 'package:flutter/material.dart';

class AnimatedEntrance extends StatelessWidget {
  final Widget child;
  final AnimationController animationController;
  final double delay; 
  final double yOffset;

  const AnimatedEntrance({
    super.key,
    required this.child,
    required this.animationController,
    this.delay = 0.0,
    this.yOffset = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    final start = delay;
    final end = (delay + 0.4).clamp(0.0, 1.0);
    
    final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(start, end, curve: Curves.easeOut),
      ),
    );
    
    final slideAnimation = Tween<Offset>(begin: Offset(0, yOffset), end: Offset.zero).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(start, end, curve: Curves.easeOutBack),
      ),
    );

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: child,
      ),
    );
  }
}
