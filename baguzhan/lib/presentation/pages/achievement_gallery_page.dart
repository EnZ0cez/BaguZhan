/// 成就画廊页面
///
/// 展示用户所有成就徽章，包括已解锁和未解锁的
library;

import 'package:flutter/material.dart';

import '../../core/theme/neo_brutal_theme.dart';
import '../../data/models/achievement_model.dart';
import '../widgets/neo/neo_container.dart';
import '../widgets/neo/neo_stat_bar.dart';

/// 成就画廊页面
class AchievementGalleryPage extends StatelessWidget {
  const AchievementGalleryPage({
    super.key,
    this.achievements,
    this.onAchievementTap,
  });

  final List<AchievementModel>? achievements;
  final void Function(AchievementModel)? onAchievementTap;

  List<AchievementModel> get _achievements =>
      achievements ?? DefaultAchievements.all;

  int get _unlockedCount => _achievements.where((a) => a.isUnlocked).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeoBrutalTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // 顶部统计栏
            NeoStatBar(
              metrics: [
                StatMetric(
                  icon: Icons.emoji_events,
                  value: '$_unlockedCount/${_achievements.length}',
                  color: NeoBrutalTheme.accent,
                ),
              ],
            ),

            // 页面标题
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    '成就徽章',
                    style: NeoBrutalTheme.styleHeadlineLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '完成挑战，收集所有徽章！',
                    style: NeoBrutalTheme.styleBodyLarge.copyWith(
                      color: NeoBrutalTheme.charcoal.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),

            // 进度概览
            _buildProgressOverview(),

            const SizedBox(height: 24),

            // 成就网格
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildAchievementGrid(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressOverview() {
    final unlocked = _unlockedCount;
    final total = _achievements.length;
    final progress = total > 0 ? unlocked / total : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: NeoContainer(
        padding: const EdgeInsets.all(20),
        color: NeoBrutalTheme.surface,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '总进度',
                  style: NeoBrutalTheme.styleHeadlineSmall,
                ),
                Text(
                  '${(progress * 100).toStringAsFixed(0)}%',
                  style: NeoBrutalTheme.styleHeadlineSmall.copyWith(
                    color: NeoBrutalTheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 进度条
            Container(
              height: 16,
              decoration: BoxDecoration(
                color: NeoBrutalTheme.lockedGray,
                borderRadius: BorderRadius.circular(NeoBrutalTheme.radiusXxs),
                border: Border.all(
                  color: NeoBrutalTheme.charcoal,
                  width: NeoBrutalTheme.borderWidth,
                ),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    color: NeoBrutalTheme.primary,
                    borderRadius:
                        BorderRadius.circular(NeoBrutalTheme.radiusXxs - 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                    '已解锁', unlocked.toString(), NeoBrutalTheme.primary),
                _buildStatItem('待解锁', (total - unlocked).toString(),
                    NeoBrutalTheme.lockedGray),
                _buildStatItem(
                    '总徽章', total.toString(), NeoBrutalTheme.charcoal),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: NeoBrutalTheme.styleHeadlineMedium.copyWith(
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: NeoBrutalTheme.styleBodyMedium.copyWith(
            color: NeoBrutalTheme.charcoal.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementGrid() {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _achievements.length,
      itemBuilder: (context, index) {
        final achievement = _achievements[index];
        return _buildAchievementCard(achievement);
      },
    );
  }

  Widget _buildAchievementCard(AchievementModel achievement) {
    final isUnlocked = achievement.isUnlocked;

    return GestureDetector(
      onTap: isUnlocked ? () => onAchievementTap?.call(achievement) : null,
      child: NeoContainer(
        color:
            isUnlocked ? NeoBrutalTheme.surface : NeoBrutalTheme.softBackground,
        padding: const EdgeInsets.all(16),
        borderRadius: NeoBrutalTheme.radiusMd,
        border: isUnlocked
            ? null
            : Border.all(
                color: NeoBrutalTheme.lockedGray,
                width: NeoBrutalTheme.borderWidth,
                style: BorderStyle.solid,
              ),
        shadow: isUnlocked ? NeoBrutalTheme.shadowMd : NeoBrutalTheme.shadowSm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 徽章图标
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: isUnlocked
                    ? NeoBrutalTheme.accent.withOpacity(0.2)
                    : NeoBrutalTheme.lockedGray.withOpacity(0.3),
                borderRadius: BorderRadius.circular(NeoBrutalTheme.radiusMd),
                border: isUnlocked
                    ? Border.all(
                        color: NeoBrutalTheme.accent,
                        width: 2,
                      )
                    : Border.all(
                        color: NeoBrutalTheme.lockedGray,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
              ),
              child: Center(
                child: Text(
                  achievement.icon,
                  style: TextStyle(
                    fontSize: 32,
                    color: isUnlocked ? null : NeoBrutalTheme.lockedGray,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // 徽章名称
            Text(
              achievement.name,
              style: NeoBrutalTheme.styleHeadlineSmall.copyWith(
                fontSize: 14,
                color: isUnlocked
                    ? NeoBrutalTheme.charcoal
                    : NeoBrutalTheme.lockedGray,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // 徽章描述
            Text(
              achievement.description,
              style: NeoBrutalTheme.styleBodyMedium.copyWith(
                fontSize: 11,
                color: isUnlocked
                    ? NeoBrutalTheme.charcoal.withOpacity(0.6)
                    : NeoBrutalTheme.lockedGray,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 8),

            // 进度或已解锁标签
            if (isUnlocked)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: NeoBrutalTheme.primary,
                  borderRadius: BorderRadius.circular(NeoBrutalTheme.radiusXxs),
                ),
                child: Text(
                  '已解锁',
                  style: NeoBrutalTheme.styleLabel.copyWith(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              )
            else
              Column(
                children: [
                  // 进度条
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: NeoBrutalTheme.lockedGray.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: achievement.progressPercent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: NeoBrutalTheme.lockedGray,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    achievement.progressText,
                    style: NeoBrutalTheme.styleLabel.copyWith(
                      fontSize: 10,
                      color: NeoBrutalTheme.lockedGray,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
