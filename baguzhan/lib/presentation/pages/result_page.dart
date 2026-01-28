import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../providers/question_provider.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuestionProvider>();
    final total = provider.questions.length;
    final accuracy = (provider.accuracy * 100).toStringAsFixed(0);
    final topic = provider.lastTopic ?? 'JavaScript';

    return Scaffold(
      appBar: AppBar(title: const Text('答题结果')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('统计', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            _StatRow(label: '总题数', value: '$total'),
            _StatRow(label: '正确数', value: '${provider.correctCount}'),
            _StatRow(label: '错误数', value: '${provider.incorrectCount}'),
            _StatRow(label: '正确率', value: '$accuracy%'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/question', arguments: topic);
                },
                child: const Text('重新开始'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.borderGray, width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('返回首页'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderGray, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
