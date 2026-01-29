import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_theme.dart';

class OptionCard extends StatefulWidget {
  const OptionCard({
    super.key,
    required this.indexLabel,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.isIncorrect,
    required this.isDisabled,
    required this.onTap,
  });

  final String indexLabel;
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool isIncorrect;
  final bool isDisabled;
  final VoidCallback onTap;

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  bool _pressed = false;

  Color _borderColor() {
    if (widget.isCorrect) {
      return AppTheme.duoGreen;
    }
    if (widget.isIncorrect) {
      return AppTheme.duoRed;
    }
    if (widget.isSelected) {
      return AppTheme.duoBlue;
    }
    return AppTheme.borderGray;
  }

  Color _backgroundColor() {
    if (widget.isCorrect) {
      return AppTheme.correctBackground;
    }
    if (widget.isIncorrect) {
      return AppTheme.incorrectBackground;
    }
    if (widget.isSelected) {
      return AppTheme.selectedBackground;
    }
    return Colors.white;
  }

  Color _indexBackgroundColor() {
    if (widget.isCorrect) {
      return AppTheme.duoGreen;
    }
    if (widget.isIncorrect) {
      return AppTheme.duoRed;
    }
    if (widget.isSelected) {
      return AppTheme.duoBlue;
    }
    return Colors.white;
  }

  Color _indexTextColor() {
    if (widget.isCorrect || widget.isIncorrect || widget.isSelected) {
      return Colors.white;
    }
    return AppTheme.textSecondary;
  }

  void _setPressed(bool value) {
    if (widget.isDisabled) {
      return;
    }
    if (_pressed == value) {
      return;
    }
    setState(() {
      _pressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final shadow = _pressed ? AppTheme.shadowPressed : AppTheme.shadowDown;
    final translateY = _pressed ? 2.0 : 0.0;

    return GestureDetector(
      onTap: widget.isDisabled
          ? null
          : () {
              HapticFeedback.lightImpact();
              widget.onTap();
            },
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: AnimatedContainer(
        duration: AppTheme.durationPress,
        curve: AppTheme.curvePress,
        transform: Matrix4.translationValues(0, translateY, 0),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: _backgroundColor(),
          borderRadius: BorderRadius.circular(AppTheme.radiusCard),
          border:
              Border.all(color: _borderColor(), width: AppTheme.borderWidth),
          boxShadow: [shadow],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _indexBackgroundColor(),
                borderRadius: BorderRadius.circular(AppTheme.radiusChip),
                border: Border.all(
                  color: _borderColor(),
                  width: AppTheme.borderWidth,
                ),
              ),
              child: Text(
                widget.indexLabel,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: _indexTextColor(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.text,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
