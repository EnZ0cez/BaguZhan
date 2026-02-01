import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/neo_brutal_theme.dart';
import '../providers/question_provider.dart';
import '../widgets/neo/neo_button.dart';
import '../widgets/neo/neo_container.dart';
import '../widgets/neo/neo_progress_ring.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuestionProvider>();
    final total = provider.questions.length;
    final accuracy = total > 0 ? provider.correctCount / total : 0.0;
    final topic = provider.lastTopic ?? 'JavaScript';

    return Scaffold(
      backgroundColor: NeoBrutalTheme.background,
      appBar: AppBar(
        title: const Text('答题结果'),
        backgroundColor: NeoBrutalTheme.background,
        foregroundColor: NeoBrutalTheme.charcoal,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题
            Text(
              '答题完成！',
              style: NeoBrutalTheme.styleHeadlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '主题: $topic',
              style: NeoBrutalTheme.styleBodyLarge.copyWith(
                color: NeoBrutalTheme.charcoal.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 32),

            // 正确率环形展示
            Center(
              child: Column(
                children: [
                  NeoProgressRing(
                    progress: accuracy,
                    size: 160,
                    strokeWidth: 12,
                    showPercentage: true,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    accuracy >= 0.8
                        ? '太棒了！🎉'
                        : accuracy >= 0.6
                            ? '做得不错！👍'
                            : '继续加油！💪',
                    style: NeoBrutalTheme.styleHeadlineMedium,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // 统计卡片
            Text(
              '详细统计',
              style: NeoBrutalTheme.styleHeadlineSmall,
            ),
            const SizedBox(height: 16),

            _StatCard(
              label: '总题数',
              value: total.toString(),
              icon: Icons.quiz,
              color: NeoBrutalTheme.secondary,
            ),
            const SizedBox(height: 12),

            _StatCard(
              label: '正确数',
              value: provider.correctCount.toString(),
              icon: Icons.check_circle,
              color: NeoBrutalTheme.primary,
            ),
            const SizedBox(height: 12),

            _StatCard(
              label: '错误数',
              value: provider.incorrectCount.toString(),
              icon: Icons.cancel,
              color: NeoBrutalTheme.error,
            ),
            const SizedBox(height: 12),

            _StatCard(
              label: '最高连击',
              value: '${provider.maxStreak}',
              icon: Icons.local_fire_department,
              color: NeoBrutalTheme.fire,
            ),

            const Spacer(),

            // 操作按钮
            NeoTextButton(
              text: '重新开始',
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/question',
                  arguments: topic,
                );
              },
              type: NeoButtonType.primary,
              size: NeoButtonSize.large,
            ),
            const SizedBox(height: 12),
            NeoTextButton(
              text: '返回首页',
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
              },
              type: NeoButtonType.outline,
              size: NeoButtonSize.large,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return NeoContainer(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(NeoBrutalTheme.radiusSm),
              border: Border.all(
                color: color,
                width: 2,
              ),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: NeoBrutalTheme.styleBodyMedium.copyWith(
                    color: NeoBrutalTheme.charcoal.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: NeoBrutalTheme.styleHeadlineMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
