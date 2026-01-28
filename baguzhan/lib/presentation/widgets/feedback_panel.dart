import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../data/models/question_model.dart';

class FeedbackPanel extends StatelessWidget {
  const FeedbackPanel({
    super.key,
    required this.isCorrect,
    required this.question,
    required this.onContinue,
    required this.isLast,
  });

  final bool isCorrect;
  final QuestionModel question;
  final VoidCallback onContinue;
  final bool isLast;

  Color get _background => isCorrect ? const Color(0xFFE9F7DD) : const Color(0xFFFFE6E6);
  Color get _textColor => isCorrect ? AppTheme.duoGreen : AppTheme.duoRed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isCorrect ? '回答正确！' : '回答错误',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: _textColor),
          ),
          const SizedBox(height: 8),
          if (!isCorrect)
            Text(
              '正确答案：${question.options[question.correctAnswerIndex].optionText}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          const SizedBox(height: 12),
          if (question.explanation != null)
            _Section(title: '解析', content: question.explanation!),
          if (question.mnemonic != null)
            _Section(title: '助记口诀', content: question.mnemonic!),
          if (question.scenario != null)
            _Section(title: '实战场景', content: question.scenario!),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              key: const ValueKey('continue-button'),
              onPressed: onContinue,
              child: Text(isLast ? '查看结果' : '下一题'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w700, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 4),
          Text(content, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
