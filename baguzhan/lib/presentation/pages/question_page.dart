import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../providers/question_provider.dart';
import '../widgets/feedback_panel.dart';
import '../widgets/option_card.dart';
import '../widgets/progress_bar.dart';
import '../widgets/question_card.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key, required this.topic});

  final String topic;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<QuestionProvider>().loadQuestions(widget.topic);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.topic)),
      body: Consumer<QuestionProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          }
          final question = provider.currentQuestion;
          if (question == null) {
            return const Center(child: Text('暂无题目'));
          }
          final isLast = provider.currentIndex == provider.questions.length - 1;
          final optionLabels = ['A', 'B', 'C', 'D'];

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              ProgressBar(
                currentIndex: provider.currentIndex,
                total: provider.questions.length,
              ),
              const SizedBox(height: 16),
              QuestionCard(question: question),
              const SizedBox(height: 16),
              ...List.generate(question.options.length, (index) {
                final option = question.options[index];
                final selected = provider.selectedOptionIndex == index;
                final correctIndex = question.correctAnswerIndex;
                final isCorrect = provider.isAnswered && index == correctIndex;
                final isIncorrect =
                    provider.isAnswered && selected && index != correctIndex;
                return OptionCard(
                  indexLabel: optionLabels[index],
                  text: option.optionText,
                  isSelected: selected,
                  isCorrect: isCorrect,
                  isIncorrect: isIncorrect,
                  isDisabled: provider.isAnswered,
                  onTap: () => provider.selectOption(index),
                );
              }),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  key: const ValueKey('submit-answer'),
                  onPressed:
                      provider.selectedOptionIndex == null || provider.isAnswered
                          ? null
                          : provider.submitAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: provider.selectedOptionIndex == null
                        ? AppTheme.borderGray
                        : AppTheme.duoGreen,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(provider.isAnswered ? '已提交' : '提交答案'),
                ),
              ),
              if (provider.isAnswered)
                FeedbackPanel(
                  isCorrect: provider.lastIsCorrect ?? false,
                  question: question,
                  isLast: isLast,
                  onContinue: () {
                    if (isLast) {
                      Navigator.pushReplacementNamed(context, '/result');
                    } else {
                      provider.nextQuestion();
                    }
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
