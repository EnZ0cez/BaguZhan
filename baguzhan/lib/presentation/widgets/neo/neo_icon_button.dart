/// Neo-Brutal 风格图标按钮组件
library;

import 'package:flutter/material.dart';

import '../../../core/theme/neo_brutal_theme.dart';

/// Neo-Brutal 图标按钮
///
/// 圆形或圆角方形按钮，包含图标
class NeoIconButton extends StatefulWidget {
  const NeoIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size,
    this.color,
    this.iconColor,
    this.backgroundColor,
    this.borderRadius,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double? size;
  final Color? color;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? borderRadius;
  final String? tooltip;

  @override
  State<NeoIconButton> createState() => _NeoIconButtonState();
}

class _NeoIconButtonState extends State<NeoIconButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: NeoBrutalTheme.durationPress,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onPressed != null) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.onPressed != null) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size ?? NeoBrutalTheme.iconButtonSize;
    final bgColor = widget.backgroundColor ?? NeoBrutalTheme.surface;
    final iconColor = widget.iconColor ??
        (widget.onPressed == null
            ? NeoBrutalTheme.charcoal.withOpacity(0.4)
            : NeoBrutalTheme.charcoal);
    final radius = widget.borderRadius ?? size / 2;

    Widget button = ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: NeoBrutalTheme.durationPress,
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(
              color: widget.color ?? NeoBrutalTheme.borderColor,
              width: NeoBrutalTheme.borderWidth,
            ),
            borderRadius: BorderRadius.circular(radius),
            boxShadow: _isPressed
                ? NeoBrutalTheme.shadowPressed
                : NeoBrutalTheme.shadowSm,
          ),
          child: Icon(
            widget.icon,
            color: iconColor,
            size: size * 0.4,
          ),
        ),
      ),
    );

    if (widget.tooltip != null) {
      button = Tooltip(message: widget.tooltip!, child: button);
    }

    return button;
  }
}

/// 垂直排列的图标按钮组（用于侧边工具栏）
class NeoIconButtonGroup extends StatelessWidget {
  const NeoIconButtonGroup({
    super.key,
    required this.buttons,
    this.spacing = NeoBrutalTheme.spaceMd,
    this.alignment = MainAxisAlignment.center,
  });

  final List<NeoIconButtonData> buttons;
  final double spacing;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: alignment,
      children: buttons
          .map((data) => Padding(
                padding: EdgeInsets.only(bottom: spacing),
                child: NeoIconButton(
                  icon: data.icon,
                  onPressed: data.onPressed,
                  size: data.size,
                  backgroundColor: data.backgroundColor,
                  tooltip: data.tooltip,
                ),
              ))
          .toList(),
    );
  }
}

/// 图标按钮数据
class NeoIconButtonData {
  const NeoIconButtonData({
    required this.icon,
    required this.onPressed,
    this.size,
    this.backgroundColor,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double? size;
  final Color? backgroundColor;
  final String? tooltip;
}
