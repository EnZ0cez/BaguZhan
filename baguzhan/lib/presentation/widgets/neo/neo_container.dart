/// Neo-Brutal 风格容器组件
///
/// 提供带硬阴影和粗边框的基础容器
library;

import 'package:flutter/material.dart';

import '../../../core/theme/neo_brutal_theme.dart';

/// Neo-Brutal 风格容器
class NeoContainer extends StatefulWidget {
  const NeoContainer({
    super.key,
    required this.child,
    this.color,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius,
    this.onTap,
    this.onLongPress,
    this.border,
    this.shadow,
    this.alignment,
    this.constraints,
  });

  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final double? borderRadius;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final BoxBorder? border;
  final List<BoxShadow>? shadow;
  final AlignmentGeometry? alignment;
  final BoxConstraints? constraints;

  @override
  State<NeoContainer> createState() => _NeoContainerState();
}

class _NeoContainerState extends State<NeoContainer>
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: NeoBrutalTheme.curvePress),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onTap != null) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.onTap != null) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isInteractive = widget.onTap != null || widget.onLongPress != null;
    final bgColor = widget.color ?? NeoBrutalTheme.surface;
    final effectiveBorder = widget.border ?? NeoBrutalTheme.createBorder();
    final effectiveShadow =
        _isPressed && widget.onTap != null
            ? NeoBrutalTheme.shadowPressed
            : (widget.shadow ?? NeoBrutalTheme.shadowMd);
    final effectiveRadius = widget.borderRadius ?? NeoBrutalTheme.borderRadius;

    Widget content = Container(
      margin: widget.margin,
      width: widget.width,
      height: widget.height,
      constraints: widget.constraints,
      padding: widget.padding,
      alignment: widget.alignment,
      decoration: BoxDecoration(
        color: bgColor,
        border: effectiveBorder,
        borderRadius: BorderRadius.circular(effectiveRadius),
        boxShadow: effectiveShadow,
      ),
      child: widget.child,
    );

    if (isInteractive) {
      content = ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          child: content,
        ),
      );
    }

    return content;
  }
}

/// Neo-Brutal 风格卡片容器
///
/// 默认白色背景，适用于统计卡片等场景
class NeoCard extends StatelessWidget {
  const NeoCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.onTap,
    this.color,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return NeoContainer(
      color: color ?? NeoBrutalTheme.surface,
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: NeoBrutalTheme.spaceMd,
            vertical: NeoBrutalTheme.spaceSm,
          ),
      margin: margin,
      width: width,
      onTap: onTap,
      child: child,
    );
  }
}
