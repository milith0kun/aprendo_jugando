import 'package:flutter/material.dart';
import '../config/app_theme.dart';

/// Botón educativo optimizado para niños
/// - Área de toque grande (mínimo 56px)
/// - Feedback visual claro
/// - Animaciones suaves
class EducationalButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final bool isSelected;
  final bool isCorrect;
  final bool isIncorrect;
  final bool showFeedback;

  const EducationalButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.isSelected = false,
    this.isCorrect = false,
    this.isIncorrect = false,
    this.showFeedback = false,
  }) : super(key: key);

  @override
  State<EducationalButton> createState() => _EducationalButtonState();
}

class _EducationalButtonState extends State<EducationalButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getBackgroundColor() {
    if (widget.showFeedback) {
      if (widget.isCorrect) return AppTheme.successColor;
      if (widget.isIncorrect) return AppTheme.dangerColor;
    }
    if (widget.isSelected) {
      return widget.backgroundColor ?? AppTheme.primaryColor.withOpacity(0.2);
    }
    return widget.backgroundColor ?? AppTheme.cardBackground;
  }

  Color _getBorderColor() {
    if (widget.showFeedback) {
      if (widget.isCorrect) return AppTheme.successColor;
      if (widget.isIncorrect) return AppTheme.dangerColor;
    }
    if (widget.isSelected) {
      return AppTheme.primaryColor;
    }
    return AppTheme.borderColor;
  }

  Color _getTextColor() {
    if (widget.showFeedback && (widget.isCorrect || widget.isIncorrect)) {
      return Colors.white;
    }
    return widget.textColor ?? AppTheme.textPrimary;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _controller.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _controller.reverse();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _controller.reverse();
      },
      onTap: widget.onPressed,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          constraints: const BoxConstraints(minHeight: 56),
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _getBorderColor(),
              width: 2,
            ),
            boxShadow: widget.showFeedback
                ? []
                : [
                    BoxShadow(
                      color: _getBorderColor().withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              if (widget.showFeedback && widget.isCorrect)
                const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.white,
                  size: 24,
                )
              else if (widget.showFeedback && widget.isIncorrect)
                const Icon(
                  Icons.cancel_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              if (widget.showFeedback && (widget.isCorrect || widget.isIncorrect))
                const SizedBox(width: 12),
              if (widget.icon != null && !widget.showFeedback) ...[
                Icon(widget.icon, color: _getTextColor(), size: 24),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _getTextColor(),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
