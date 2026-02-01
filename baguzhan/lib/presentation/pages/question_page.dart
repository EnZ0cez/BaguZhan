import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../core/theme/neo_brutal_theme.dart';
import '../providers/question_provider.dart';
import '../widgets/feedback_panel.dart';
import '../widgets/neo/neo_button.dart';
import '../widgets/neo/neo_container.dart';
import '../widgets/neo/neo_progress_ring.dart';
import '../widgets/option_card.dart';
import '../widgets/progress_bar.dart';
import '../widgets/question_card.dart';
import '../widgets/status_view.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key, required this.topic});

  final String topic;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      context.read<QuestionProvider>().loadQuestions(widget.topic);
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeoBrutalTheme.background,
      appBar: AppBar(
        title: Text(widget.topic),
        backgroundColor: NeoBrutalTheme.background,
        foregroundColor: NeoBrutalTheme.charcoal,
        elevation: 0,
      ),
      body: Consumer<QuestionProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const LoadingStateView();
          }
          if (provider.errorMessage != null) {
            return MessageStateView(
              icon: Icons.wifi_off,
              title: '加载失败',
              subtitle: provider.errorMessage!,
              actionLabel: '重试',
              onAction: () => provider.loadQuestions(widget.topic),
            );
          }
          final question = provider.currentQuestion;
          if (question == null) {
            return const MessageStateView(
              icon: Icons.inbox,
              title: '暂无题目',
              subtitle: '换个主题试试，或者稍后再来。',
            );
          }
          final isLast = provider.currentIndex == provider.questions.length - 1;
          final optionLabels = ['A', 'B', 'C', 'D'];

          return LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final horizontalPadding =
                  width >= 600 ? 32.0 : (width <= 360 ? 16.0 : 20.0);

              return Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      20,
                      horizontalPadding,
                      20,
                    ),
                    children: [
                      // 进度条
                      ProgressBar(
                        currentIndex: provider.currentIndex,
                        total: provider.questions.length,
                        streak: provider.currentStreak,
                      ),
                      const SizedBox(height: 16),

                      // 题目卡片
                      QuestionCard(question: question),
                      const SizedBox(height: 16),

                      // 选项卡片
                      ...List.generate(question.options.length, (index) {
                        final option = question.options[index];
                        final selected = provider.selectedOptionIndex == index;
                        final correctIndex = question.correctAnswerIndex;
                        final isCorrect =
                            provider.isAnswered && index == correctIndex;
                        final isIncorrect = provider.isAnswered &&
                            selected &&
                            index != correctIndex;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _NeoOptionCard(
                            indexLabel: optionLabels[index],
                            text: option.optionText,
                            isSelected: selected,
                            isCorrect: isCorrect,
                            isIncorrect: isIncorrect,
                            isDisabled: provider.isAnswered,
                            onTap: () => provider.selectOption(index),
                          ),
                        );
                      }),

                      const SizedBox(height: 16),

                      // 提交按钮
                      NeoTextButton(
                        text: provider.isAnswered ? '已提交' : '提交答案',
                        onPressed: provider.selectedOptionIndex == null ||
                                provider.isAnswered
                            ? null
                            : provider.submitAnswer,
                        type: NeoButtonType.primary,
                        size: NeoButtonSize.large,
                      ),

                      const SizedBox(height: 16),

                      // 反馈面板
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        switchInCurve: Curves.easeOutBack,
                        switchOutCurve: Curves.easeIn,
                        transitionBuilder: (child, animation) {
                          final slide = Tween<Offset>(
                            begin: const Offset(0, 0.1),
                            end: Offset.zero,
                          ).animate(animation);
                          return FadeTransition(
                            opacity: animation,
                            child:
                                SlideTransition(position: slide, child: child),
                          );
                        },
                        child: provider.isAnswered
                            ? FeedbackPanel(
                                key: ValueKey('feedback-${question.id}'),
                                isCorrect: provider.lastIsCorrect ?? false,
                                question: question,
                                isLast: isLast,
                                onContinue: () {
                                  if (isLast) {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      '/result',
                                    );
                                  } else {
                                    provider.nextQuestion();
                                  }
                                },
                              )
                            : const SizedBox.shrink(
                                key: ValueKey('feedback-empty')),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// Neo 风格选项卡片
class _NeoOptionCard extends StatefulWidget {
  const _NeoOptionCard({
    required this.indexLabel,
    required this.text,
    this.isSelected = false,
    this.isCorrect = false,
    this.isIncorrect = false,
    this.isDisabled = false,
    this.onTap,
  });

  final String indexLabel;
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool isIncorrect;
  final bool isDisabled;
  final VoidCallback? onTap;

  @override
  State<_NeoOptionCard> createState() => _NeoOptionCardState();
}

class _NeoOptionCardState extends State<_NeoOptionCard> {
  bool _isPressed = false;

  Color get _backgroundColor {
    if (widget.isCorrect) return const Color(0xFFE9F7DD);
    if (widget.isIncorrect) return const Color(0xFFFFE6E6);
    if (widget.isSelected) return const Color(0xFFE8F5FE);
    return NeoBrutalTheme.surface;
  }

  Color get _borderColor {
    if (widget.isCorrect) return NeoBrutalTheme.primary;
    if (widget.isIncorrect) return NeoBrutalTheme.error;
    if (widget.isSelected) return NeoBrutalTheme.secondary;
    return NeoBrutalTheme.charcoal;
  }

  @override
  Widget build(BuildContext context) {
    final isInteractive = !widget.isDisabled && widget.onTap != null;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: isInteractive
          ? (_) {
              HapticFeedback.lightImpact();
              setState(() => _isPressed = true);
            }
          : null,
      onTapUp: isInteractive ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel:
          isInteractive ? () => setState(() => _isPressed = false) : null,
      child: AnimatedContainer(
        duration: NeoBrutalTheme.durationPress,
        curve: NeoBrutalTheme.curvePress,
        transform: Matrix4.translationValues(
          _isPressed ? 4 : 0,
          _isPressed ? 4 : 0,
          0,
        ),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(NeoBrutalTheme.radiusSm),
          border: Border.all(
            color: _borderColor,
            width: NeoBrutalTheme.borderWidth,
          ),
          boxShadow: _isPressed
              ? NeoBrutalTheme.shadowPressed
              : NeoBrutalTheme.shadowMd,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _borderColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(NeoBrutalTheme.radiusXxs),
                  border: Border.all(
                    color: _borderColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.indexLabel,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _borderColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.text,
                  style: NeoBrutalTheme.styleBodyLarge,
                ),
              ),
              if (widget.isCorrect)
                const Icon(Icons.check_circle, color: NeoBrutalTheme.primary)
              else if (widget.isIncorrect)
                const Icon(Icons.cancel, color: NeoBrutalTheme.error),
            ],
          ),
        ),
      ),
    );
  }
}
