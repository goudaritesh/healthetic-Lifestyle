import 'package:flutter/material.dart';
import '../constants/colors.dart';

class BrandedButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;

  const BrandedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  State<BrandedButton> createState() => _BrandedButtonState();
}

class _BrandedButtonState extends State<BrandedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.98).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onPointerDown(PointerDownEvent event) {
    if (!widget.isDisabled && !widget.isLoading) {
      _animationController.forward();
    }
  }

  void _onPointerUp(PointerUpEvent event) {
    if (!widget.isDisabled && !widget.isLoading) {
      _animationController.reverse();
    }
  }

  void _onPointerCancel(PointerCancelEvent event) {
    if (!widget.isDisabled && !widget.isLoading) {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: widget.isDisabled ? 0.6 : 1.0,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    disabledBackgroundColor: primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: (widget.isDisabled || widget.isLoading)
                      ? null
                      : widget.onPressed,
                  child: widget.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(neutralWhite),
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          widget.label,
                          style: const TextStyle(
                            color: neutralWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
