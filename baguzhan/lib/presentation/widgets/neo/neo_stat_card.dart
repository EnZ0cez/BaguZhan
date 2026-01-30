/// Neo-Brutal 风格统计卡片组件
library;

import 'package:flutter/material.dart';

import '../../../core/theme/neo_brutal_theme.dart';
import 'neo_container.dart';

/// 统计卡片数据模型
class StatItem {
  const StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    this.iconBgColor,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final Color? iconBgColor;
}

/// Neo-Brutal 统计卡片
///
/// 用于展示单个统计数据，如连续天数、正确率等
class NeoStatCard extends StatelessWidget {
  const NeoStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    this.iconBgColor,
    this.onTap,
    this.width,
  });

  factory NeoStatCard.fromItem(StatItem item, {VoidCallback? onTap, double? width}) {
    return NeoStatCard(
      icon: item.icon,
      value: item.value,
      label: item.label,
      color: item.color,
      iconBgColor: item.iconBgColor,
      onTap: onTap,
      width: width,
    );
  }

  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final Color? iconBgColor;
  final VoidCallback? onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return NeoContainer(
      color: NeoBrutalTheme.surface,
      padding: const EdgeInsets.symmetric(
        horizontal: NeoBrutalTheme.spaceSm,
        vertical: NeoBrutalTheme.spaceMd,
      ),
      width: width,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 图标 + 标签
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconBgColor ?? color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(NeoBrutalTheme.radiusXxs),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: NeoBrutalTheme.spaceXs),
              Expanded(
                child: Text(
                  label,
                  style: NeoBrutalTheme.styleLabel.copyWith(
                    color: NeoBrutalTheme.charcoal.withOpacity(0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: NeoBrutalTheme.spaceSm),
          // 数值
          Text(
            value,
            style: NeoBrutalTheme.styleHeadlineSmall.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

/// 横向统计卡片行
///
/// 自动平分宽度展示多个统计卡片
class NeoStatRow extends StatelessWidget {
  const NeoStatRow({
    super.key,
    required this.stats,
    this.gap = NeoBrutalTheme.spaceSm,
  });

  final List<StatItem> stats;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: stats.map((stat) {
        final index = stats.indexOf(stat);
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: index < stats.length - 1 ? gap : 0,
            ),
            child: NeoStatCard.fromItem(stat),
          ),
        );
      }).toList(),
    );
  }
}

/// 迷你统计卡片（用于顶部统计栏）
class NeoMiniStatCard extends StatelessWidget {
  const NeoMiniStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.color,
    this.valueColor,
  });

  final IconData icon;
  final String value;
  final Color color;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return NeoContainer(
      color: NeoBrutalTheme.surface,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 6,
      ),
      borderRadius: NeoBrutalTheme.radiusXxs,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 18,
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: valueColor ?? NeoBrutalTheme.charcoal,
            ),
          ),
        ],
      ),
    );
  }
}
