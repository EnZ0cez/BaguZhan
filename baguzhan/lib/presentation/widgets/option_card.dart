import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class OptionCard extends StatelessWidget {
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

  Color _borderColor() {
    if (isCorrect) {
      return AppTheme.duoGreen;
    }
    if (isIncorrect) {
      return AppTheme.duoRed;
    }
    if (isSelected) {
      return AppTheme.duoBlue;
    }
    return AppTheme.borderGray;
  }

  Color _backgroundColor() {
    if (isCorrect) {
      return const Color(0xFFE9F7DD);
    }
    if (isIncorrect) {
      return const Color(0xFFFFE6E6);
    }
    if (isSelected) {
      return const Color(0xFFE8F5FE);
    }
    return Colors.white;
  }

  Color _indexBackgroundColor() {
    if (isCorrect) {
      return AppTheme.duoGreen;
    }
    if (isIncorrect) {
      return AppTheme.duoRed;
    }
    if (isSelected) {
      return AppTheme.duoBlue;
    }
    return Colors.white;
  }

  Color _indexTextColor() {
    if (isCorrect || isIncorrect || isSelected) {
      return Colors.white;
    }
    return AppTheme.textSecondary;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: _backgroundColor(),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _borderColor(), width: 2),
          boxShadow: [
            BoxShadow(
              color: AppTheme.borderGray,
              offset: const Offset(0, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _indexBackgroundColor(),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _borderColor(), width: 2),
              ),
              child: Text(
                indexLabel,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: _indexTextColor(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
