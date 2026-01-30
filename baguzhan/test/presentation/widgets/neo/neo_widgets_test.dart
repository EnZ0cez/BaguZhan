import 'package:baguzhan/core/theme/neo_brutal_theme.dart';
import 'package:baguzhan/presentation/widgets/neo/neo_stat_bar.dart';
import 'package:baguzhan/presentation/widgets/neo/neo_unit_banner.dart';
import 'package:baguzhan/presentation/widgets/neo/neo_progress_ring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NeoStatBar', () {
    testWidgets('renders standard stats', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NeoStatBar.standard(
              streak: 5,
              accuracy: 0.85,
              totalQuestions: 100,
              xp: 1200,
            ),
          ),
        ),
      );

      // 验证所有统计数据都显示
      expect(find.text('5天'), findsOneWidget);
      expect(find.text('85%'), findsOneWidget);
      expect(find.text('100题'), findsOneWidget);
      expect(find.text('1.2k'), findsOneWidget);
    });

    testWidgets('renders custom metrics', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NeoStatBar(
              metrics: [
                StatMetric(
                  icon: Icons.star,
                  value: '10',
                  color: NeoBrutalTheme.accent,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('10'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });
  });

  group('NeoUnitBanner', () {
    testWidgets('renders unit information', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NeoUnitBanner(
              unit: 1,
              part: 5,
              topic: 'JavaScript Closures',
              subtitle: 'Master memory & scope',
            ),
          ),
        ),
      );

      expect(find.text('Unit 1, Part 5'), findsOneWidget);
      expect(find.text('JavaScript Closures'), findsOneWidget);
      expect(find.text('Master memory & scope'), findsOneWidget);
    });
  });

  group('NeoProgressRing', () {
    testWidgets('renders with progress', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NeoProgressRing(
              progress: 0.75,
              size: 100,
            ),
          ),
        ),
      );

      expect(find.byType(NeoProgressRing), findsOneWidget);
    });

    testWidgets('renders with percentage', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NeoProgressRing(
              progress: 0.5,
              size: 100,
              showPercentage: true,
            ),
          ),
        ),
      );

      expect(find.text('50%'), findsOneWidget);
    });
  });

  group('NeoProgressButton', () {
    testWidgets('renders with button', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NeoProgressButton(
              progress: 0.6,
              size: 120,
              buttonIcon: Icons.play_arrow,
              buttonLabel: 'START',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      expect(find.text('START'), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);

      await tester.tap(find.text('START'));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });
  });
}
