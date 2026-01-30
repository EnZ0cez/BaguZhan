/// Neo-Brutalism 主题系统
///
/// 提供统一的新粗犷主义设计风格配置，包括：
/// - 硬阴影（无模糊）
/// - 粗边框（3px）
/// - 高对比度配色
/// - 大圆角（16-24px）
library;

import 'package:flutter/material.dart';

import 'app_theme.dart';

/// Neo-Brutal 主题令牌
class NeoBrutalTheme {
  NeoBrutalTheme._();

  // ==================== 颜色系统 ====================

  /// 主色 - 亮绿（核心操作、进度）
  static const Color primary = AppTheme.duoGreen; // #58CC02

  /// 辅助色 - 天蓝（信息、数据）
  static const Color secondary = AppTheme.duoBlue; // #1CB0F6

  /// 强调色 - 金黄（成就、奖励、高亮）
  static const Color accent = Color(0xFFFFC800); // #FFC800

  /// 错误色 - 红色
  static const Color error = AppTheme.duoRed; // #FF4B4B

  /// 火焰橙 - 连续天数
  static const Color fire = Color(0xFFFF6B35);

  /// 钻石紫 - 积分/经验值
  static const Color diamond = Color(0xFF6366F1);

  /// 炭灰 - 边框、阴影、文字
  static const Color charcoal = Color(0xFF2D3436);

  /// 背景色 - 浅米白
  static const Color background = Color(0xFFF9FAFB);

  /// 表面色 - 白色
  static const Color surface = Color(0xFFFFFFFF);

  /// 路径线灰
  static const Color pathLine = Color(0xFFE5E7EB);

  /// 锁定状态灰
  static const Color lockedGray = Color(0xFFD1D5DB);

  /// 浅背景色（用于卡片等）
  static const Color softBackground = Color(0xFFF7F7F7);

  // ==================== 阴影系统 ====================

  /// 小硬阴影 - 4px 偏移
  static const List<BoxShadow> shadowSm = [
    BoxShadow(
      color: charcoal,
      offset: Offset(0, 4),
      blurRadius: 0,
      spreadRadius: 0,
    ),
  ];

  /// 中硬阴影 - 6px 偏移
  static const List<BoxShadow> shadowMd = [
    BoxShadow(
      color: charcoal,
      offset: Offset(0, 6),
      blurRadius: 0,
      spreadRadius: 0,
    ),
  ];

  /// 大硬阴影 - 8px 偏移
  static const List<BoxShadow> shadowLg = [
    BoxShadow(
      color: charcoal,
      offset: Offset(0, 8),
      blurRadius: 0,
      spreadRadius: 0,
    ),
  ];

  /// 节点激活阴影（用于学习路径节点）
  static const List<BoxShadow> shadowNodeActive = [
    BoxShadow(
      color: charcoal,
      offset: Offset(0, 8),
      blurRadius: 0,
      spreadRadius: 0,
    ),
  ];

  /// 节点锁定阴影
  static const List<BoxShadow> shadowNodeLocked = [
    BoxShadow(
      color: lockedGray,
      offset: Offset(0, 8),
      blurRadius: 0,
      spreadRadius: 0,
    ),
  ];

  /// 按下状态阴影（无阴影）
  static const List<BoxShadow> shadowPressed = [];

  // ==================== 边框 ====================

  /// 边框宽度
  static const double borderWidth = 3.0;

  /// 边框颜色
  static const Color borderColor = charcoal;

  /// 边框半径（默认）
  static const double borderRadius = 16.0;

  // ==================== 圆角 ====================

  /// 极小圆角
  static const double radiusXxs = 8.0;

  /// 小圆角
  static const double radiusSm = 12.0;

  /// 中圆角（默认）
  static const double radiusMd = 16.0;

  /// 大圆角
  static const double radiusLg = 24.0;

  /// 超大圆角
  static const double radiusXl = 32.0;

  /// 完整圆形
  static const double radiusFull = 9999.0;

  // ==================== 尺寸 ====================

  /// 按钮高度 - 小
  static const double buttonHeightSm = 40.0;

  /// 按钮高度 - 中
  static const double buttonHeightMd = 48.0;

  /// 按钮高度 - 大
  static const double buttonHeightLg = 56.0;

  /// 图标按钮尺寸
  static const double iconButtonSize = 48.0;

  /// 统计卡片最小宽度
  static const double statCardMinWidth = 80.0;

  /// 进度环尺寸
  static const double progressRingSize = 144.0;

  // ==================== 间距 ====================

  /// 极小间距
  static const double spaceXxs = 4.0;

  /// 小间距
  static const double spaceXs = 8.0;

  /// 中小间距
  static const double spaceSm = 12.0;

  /// 中间距
  static const double spaceMd = 16.0;

  /// 大间距
  static const double spaceLg = 24.0;

  /// 超大间距
  static const double spaceXl = 32.0;

  // ==================== 动画 ====================

  /// 按下动画时长
  static const Duration durationPress = Duration(milliseconds: 100);

  /// 进度动画时长
  static const Duration durationProgress = Duration(milliseconds: 500);

  /// 按下动画曲线
  static const Curve curvePress = Curves.easeInOut;

  /// 进度动画曲线
  static const Curve curveProgress = Curves.easeOutQuart;

  // ==================== 文字样式 ====================

  /// 大标题样式
  static const TextStyle styleHeadlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: charcoal,
    height: 1.2,
  );

  /// 中标题样式
  static const TextStyle styleHeadlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: charcoal,
    height: 1.3,
  );

  /// 小标题样式
  static const TextStyle styleHeadlineSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: charcoal,
    height: 1.3,
  );

  /// 正文样式
  static const TextStyle styleBodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: charcoal,
    height: 1.5,
  );

  /// 小正文样式
  static const TextStyle styleBodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: charcoal,
    height: 1.5,
  );

  /// 标签样式
  static const TextStyle styleLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.4,
  );

  // ==================== 辅助方法 ====================

  /// 获取按下状态偏移量
  static Offset getPressedOffset() {
    return const Offset(4, 4);
  }

  /// 创建边框
  static BoxBorder createBorder({Color? color, double? width}) {
    return Border.all(
      color: color ?? borderColor,
      width: width ?? borderWidth,
    );
  }

  /// 创建圆角
  static BorderRadius createBorderRadius([double? radius]) {
    return BorderRadius.circular(radius ?? borderRadius);
  }

  /// 创建装饰
  static BoxDecoration createDecoration({
    Color? color,
    BoxBorder? border,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      color: color ?? surface,
      border: border ?? createBorder(),
      borderRadius: borderRadius ?? createBorderRadius(),
      boxShadow: boxShadow ?? shadowMd,
    );
  }
}

/// Neo 按钮尺寸枚举
enum NeoButtonSize {
  small,
  medium,
  large,
}

/// Neo 按钮类型枚举
enum NeoButtonType {
  primary,
  secondary,
  accent,
  outline,
}
