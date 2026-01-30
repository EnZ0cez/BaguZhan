/// 章节/单元完成庆祝页面
///
/// 展示完成成就、统计数据和彩带动画
library;

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/neo_brutal_theme.dart';
import '../../data/models/achievement_model.dart';
import '../../data/models/unit_progress_model.dart';
import '../widgets/neo/neo_button.dart';
import '../widgets/neo/neo_container.dart';

/// 庆祝页面参数
class CelebrationPageParams {
  final String title;
  final String subtitle;
  final String badgeEmoji;
  final String badgeTitle;
  final List<CelebrationStat> stats;
  final List<AchievementModel> unlockedAchievements;
  final VoidCallback? onContinue;
  final VoidCallback? onShare;

  const CelebrationPageParams({
    required this.title,
    required this.subtitle,
    required this.badgeEmoji,
    required this.badgeTitle,
    required this.stats,
    this.unlockedAchievements = const [],
    this.onContinue,
    this.onShare,
  });
}

/// 统计数据项
class CelebrationStat {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const CelebrationStat({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });
}

/// 章节/单元完成庆祝页面
class CelebrationPage extends StatefulWidget {
  const CelebrationPage({
    super.key,
    this.params,
    this.unitProgress,
    this.partProgress,
  });

  final CelebrationPageParams? params;
  final UnitProgressModel? unitProgress;
  final PartProgressModel? partProgress;

  @override
  State<CelebrationPage> createState() => _CelebrationPageState();
}

class _CelebrationPageState extends State<CelebrationPage>
    with TickerProviderStateMixin {
  late AnimationController _badgeController;
  late AnimationController _confettiController;
  late Animation<double> _badgeScale;
  late Animation<double> _badgeRotation;

  @override
  void initState() {
    super.initState();
    _badgeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _badgeScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.2), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 40),
    ]).animate(CurvedAnimation(
      parent: _badgeController,
      curve: Curves.elasticOut,
    ));

    _badgeRotation = Tween<double>(begin: -0.2, end: 0.0).animate(
      CurvedAnimation(parent: _badgeController, curve: Curves.easeOutBack),
    );

    // 启动动画
    Future.delayed(const Duration(milliseconds: 300), () {
      _badgeController.forward();
      _confettiController.forward();
    });
  }

  @override
  void dispose() {
    _badgeController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  CelebrationPageParams get _params {
    if (widget.params != null) return widget.params!;

    // 根据 unit/part progress 生成默认参数
    final part = widget.partProgress;
    final unit = widget.unitProgress;

    return CelebrationPageParams(
      title: part?.isCompleted == true ? '章节完成！' : '学习进度 +1',
      subtitle:
          unit != null ? '${unit.unitName} - ${part?.topic ?? ''}' : '继续加油！',
      badgeEmoji: part?.isCompleted == true ? '🏆' : '⭐',
      badgeTitle: part?.isCompleted == true ? '完成' : '进度',
      stats: [
        if (part != null)
          CelebrationStat(
            label: '正确率',
            value: part.accuracyPercentage,
            icon: Icons.check_circle,
            color: NeoBrutalTheme.primary,
          ),
        CelebrationStat(
          label: '获得 XP',
          value: '+${(part?.correctAnswers ?? 0) * 10}',
          icon: Icons.diamond,
          color: NeoBrutalTheme.diamond,
        ),
        CelebrationStat(
          label: '用时',
          value: '5:32',
          icon: Icons.timer,
          color: NeoBrutalTheme.secondary,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeoBrutalTheme.background,
      body: Stack(
        children: [
          // 彩带背景
          ConfettiAnimation(controller: _confettiController),

          // 主内容
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),

                // 标题
                Text(
                  _params.title,
                  style: NeoBrutalTheme.styleHeadlineLarge.copyWith(
                    fontSize: 36,
                    color: NeoBrutalTheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _params.subtitle,
                  style: NeoBrutalTheme.styleBodyLarge.copyWith(
                    color: NeoBrutalTheme.charcoal.withOpacity(0.7),
                  ),
                ),

                const SizedBox(height: 40),

                // 徽章动画
                AnimatedBuilder(
                  animation: _badgeController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _badgeScale.value,
                      child: Transform.rotate(
                        angle: _badgeRotation.value,
                        child: _buildBadge(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),

                // 统计数据
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _params.stats
                        .map((stat) => _buildStatCard(stat))
                        .toList(),
                  ),
                ),

                const Spacer(),

                // 解锁的成就
                if (_params.unlockedAchievements.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '解锁成就',
                          style: NeoBrutalTheme.styleHeadlineSmall,
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 100,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _params.unlockedAchievements.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              final achievement =
                                  _params.unlockedAchievements[index];
                              return _buildAchievementCard(achievement);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // 按钮组
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      NeoTextButton(
                        text: '继续学习',
                        onPressed: _params.onContinue ??
                            () => Navigator.of(context).pop(),
                        type: NeoButtonType.primary,
                        size: NeoButtonSize.large,
                        width: double.infinity,
                      ),
                      const SizedBox(height: 12),
                      if (_params.onShare != null)
                        NeoTextButton(
                          text: '分享成绩',
                          onPressed: _params.onShare,
                          type: NeoButtonType.outline,
                          size: NeoButtonSize.medium,
                          width: double.infinity,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge() {
    return NeoContainer(
      width: 140,
      height: 140,
      color: NeoBrutalTheme.accent,
      borderRadius: NeoBrutalTheme.radiusLg,
      shadow: NeoBrutalTheme.shadowLg,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _params.badgeEmoji,
            style: const TextStyle(fontSize: 56),
          ),
          const SizedBox(height: 4),
          Text(
            _params.badgeTitle,
            style: NeoBrutalTheme.styleBodyLarge.copyWith(
              color: NeoBrutalTheme.charcoal,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(CelebrationStat stat) {
    return NeoContainer(
      width: 100,
      padding: const EdgeInsets.all(16),
      borderRadius: NeoBrutalTheme.radiusMd,
      color: NeoBrutalTheme.surface,
      child: Column(
        children: [
          Icon(stat.icon, color: stat.color, size: 28),
          const SizedBox(height: 8),
          Text(
            stat.value,
            style: NeoBrutalTheme.styleHeadlineSmall.copyWith(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat.label,
            style: NeoBrutalTheme.styleBodyMedium.copyWith(
              fontSize: 12,
              color: NeoBrutalTheme.charcoal.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(AchievementModel achievement) {
    return NeoContainer(
      width: 80,
      padding: const EdgeInsets.all(12),
      borderRadius: NeoBrutalTheme.radiusMd,
      color: NeoBrutalTheme.accent.withOpacity(0.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            achievement.icon,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 4),
          Text(
            achievement.name,
            style: NeoBrutalTheme.styleLabel.copyWith(
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/// 彩带动画组件
class ConfettiAnimation extends StatelessWidget {
  final AnimationController controller;

  const ConfettiAnimation({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: ConfettiPainter(
            progress: controller.value,
          ),
        );
      },
    );
  }
}

/// 彩带绘制器
class ConfettiPainter extends CustomPainter {
  final double progress;

  ConfettiPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42); // 固定种子保证可重现
    final colors = [
      NeoBrutalTheme.primary,
      NeoBrutalTheme.accent,
      NeoBrutalTheme.secondary,
      NeoBrutalTheme.diamond,
      NeoBrutalTheme.fire,
    ];

    for (int i = 0; i < 50; i++) {
      final x = random.nextDouble() * size.width;
      final startY = -50.0;
      final endY = size.height + 50;
      final currentY = startY + (endY - startY) * progress;

      // 添加一些随机摆动
      final wobble = math.sin(progress * math.pi * 4 + i) * 30;

      final paint = Paint()
        ..color = colors[i % colors.length].withOpacity(1 - progress * 0.5)
        ..style = PaintingStyle.fill;

      final rect = Rect.fromCenter(
        center: Offset(x + wobble, currentY),
        width: 8,
        height: 12,
      );

      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
