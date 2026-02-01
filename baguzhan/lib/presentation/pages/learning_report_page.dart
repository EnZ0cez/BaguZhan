import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/neo_brutal_theme.dart';
import '../providers/learning_progress_provider.dart';
import '../providers/wrong_book_provider.dart';
import '../widgets/neo/neo_widgets.dart';

/// 学习报告页面 - Neo-Brutal 风格
class LearningReportPage extends StatefulWidget {
  const LearningReportPage({super.key});

  @override
  State<LearningReportPage> createState() => _LearningReportPageState();
}

class _LearningReportPageState extends State<LearningReportPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LearningProgressProvider>().loadProgress();
      context.read<WrongBookProvider>().loadWrongBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeoBrutalTheme.background,
      appBar: AppBar(
        title: const Text('学习报告'),
        backgroundColor: NeoBrutalTheme.background,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<LearningProgressProvider>().refresh();
          await context.read<WrongBookProvider>().refresh();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(NeoBrutalTheme.spaceMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProgressSection(),
              const SizedBox(height: NeoBrutalTheme.spaceLg),
              _buildWrongBookSection(),
              const SizedBox(height: NeoBrutalTheme.spaceLg),
              _buildStreakSection(),
              const SizedBox(height: NeoBrutalTheme.spaceLg),
              _buildAccuracySection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressSection() {
    return Consumer<LearningProgressProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: NeoBrutalTheme.primary,
            ),
          );
        }

        final progress = provider.progress;
        if (progress == null) {
          return NeoContainer(
            color: NeoBrutalTheme.surface,
            padding: const EdgeInsets.all(NeoBrutalTheme.spaceLg),
            child: const Center(
              child: Text('暂无数据'),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '答题统计',
              style: NeoBrutalTheme.styleHeadlineSmall,
            ),
            const SizedBox(height: NeoBrutalTheme.spaceMd),
            NeoStatRow(
              stats: [
                StatItem(
                  icon: Icons.assignment,
                  value: progress.totalAnswered.toString(),
                  label: '总答题数',
                  color: NeoBrutalTheme.secondary,
                ),
                StatItem(
                  icon: Icons.check_circle,
                  value: progress.accuracyPercentage,
                  label: '正确率',
                  color: NeoBrutalTheme.primary,
                ),
              ],
            ),
            const SizedBox(height: NeoBrutalTheme.spaceSm),
            NeoStatRow(
              stats: [
                StatItem(
                  icon: Icons.done,
                  value: progress.totalCorrect.toString(),
                  label: '正确数',
                  color: NeoBrutalTheme.primary,
                ),
                StatItem(
                  icon: Icons.close,
                  value: (progress.totalAnswered - progress.totalCorrect)
                      .toString(),
                  label: '错误数',
                  color: NeoBrutalTheme.error,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildWrongBookSection() {
    return Consumer<WrongBookProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '错题本',
              style: NeoBrutalTheme.styleHeadlineSmall,
            ),
            const SizedBox(height: NeoBrutalTheme.spaceMd),
            NeoStatRow(
              stats: [
                StatItem(
                  icon: Icons.book,
                  value: provider.totalCount.toString(),
                  label: '总错题数',
                  color: NeoBrutalTheme.accent,
                ),
                StatItem(
                  icon: Icons.pending_actions,
                  value: provider.unmasteredCount.toString(),
                  label: '未掌握',
                  color: NeoBrutalTheme.error,
                ),
              ],
            ),
            const SizedBox(height: NeoBrutalTheme.spaceSm),
            NeoStatCard(
              icon: Icons.check_circle_outline,
              value: provider.masteredCount.toString(),
              label: '已掌握',
              color: NeoBrutalTheme.primary,
            ),
          ],
        );
      },
    );
  }

  Widget _buildStreakSection() {
    return Consumer<LearningProgressProvider>(
      builder: (context, provider, child) {
        final progress = provider.progress;
        if (progress == null) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '连续学习',
              style: NeoBrutalTheme.styleHeadlineSmall,
            ),
            const SizedBox(height: NeoBrutalTheme.spaceMd),
            NeoStatRow(
              stats: [
                StatItem(
                  icon: Icons.local_fire_department,
                  value: '${progress.currentStreak}',
                  label: '当前连续（天）',
                  color: NeoBrutalTheme.fire,
                ),
                StatItem(
                  icon: Icons.emoji_events,
                  value: '${progress.longestStreak}',
                  label: '最长连续（天）',
                  color: NeoBrutalTheme.accent,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildAccuracySection() {
    return Consumer<LearningProgressProvider>(
      builder: (context, provider, child) {
        final progress = provider.progress;
        if (progress == null) return const SizedBox.shrink();

        return NeoContainer(
          color: NeoBrutalTheme.surface,
          padding: const EdgeInsets.all(NeoBrutalTheme.spaceLg),
          child: Column(
            children: [
              Text(
                '正确率概览',
                style: NeoBrutalTheme.styleHeadlineSmall,
              ),
              const SizedBox(height: NeoBrutalTheme.spaceMd),
              SizedBox(
                width: 120,
                height: 120,
                child: NeoProgressRing(
                  progress: progress.accuracyRate,
                  size: 120,
                  strokeWidth: 10,
                  showPercentage: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
