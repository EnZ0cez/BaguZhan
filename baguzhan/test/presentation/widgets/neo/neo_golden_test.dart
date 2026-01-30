import 'package:baguzhan/core/theme/app_theme.dart';
import 'package:baguzhan/core/theme/neo_brutal_theme.dart';
import 'package:baguzhan/presentation/widgets/neo/neo_button.dart';
import 'package:baguzhan/presentation/widgets/neo/neo_container.dart';
import 'package:baguzhan/presentation/widgets/neo/neo_progress_ring.dart';
import 'package:baguzhan/presentation/widgets/neo/neo_stat_bar.dart';
import 'package:baguzhan/presentation/widgets/neo/neo_unit_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pumpGolden(
  WidgetTester tester,
  Widget child, {
  Size size = const Size(390, 844),
}) async {
  await tester.binding.setSurfaceSize(size);
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        backgroundColor: NeoBrutalTheme.background,
        body: Center(child: child),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  group('Neo Widgets Golden Tests', () {
    testWidgets('golden - NeoButton variants', (tester) async {
      await _pumpGolden(
        tester,
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Primary button
              NeoTextButton(
                text: 'Primary',
                onPressed: () {},
                type: NeoButtonType.primary,
              ),
              const SizedBox(height: 12),
              // Secondary button
              NeoTextButton(
                text: 'Secondary',
                onPressed: () {},
                type: NeoButtonType.secondary,
              ),
              const SizedBox(height: 12),
              // Accent button
              NeoTextButton(
                text: 'Accent',
                onPressed: () {},
                type: NeoButtonType.accent,
              ),
              const SizedBox(height: 12),
              // Outline button
              NeoTextButton(
                text: 'Outline',
                onPressed: () {},
                type: NeoButtonType.outline,
              ),
              const SizedBox(height: 12),
              // Disabled button
              const NeoTextButton(
                text: 'Disabled',
                onPressed: null,
              ),
            ],
          ),
        ),
        size: const Size(390, 400),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/neo_buttons.png'),
      );
    });

    testWidgets('golden - NeoContainer variants', (tester) async {
      await _pumpGolden(
        tester,
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Default container
              const NeoContainer(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Text('Default Container'),
              ),
              const SizedBox(height: 12),
              // Colored container
              NeoContainer(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: NeoBrutalTheme.primary,
                child: const Text(
                  'Primary Color',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              // Card
              const NeoCard(
                width: double.infinity,
                child: Text('NeoCard'),
              ),
            ],
          ),
        ),
        size: const Size(390, 320),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/neo_containers.png'),
      );
    });

    testWidgets('golden - NeoProgressRing', (tester) async {
      await _pumpGolden(
        tester,
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NeoProgressRing(
                    progress: 0.25,
                    size: 80,
                    showPercentage: true,
                  ),
                  const SizedBox(height: 8),
                  const Text('25%'),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NeoProgressRing(
                    progress: 0.5,
                    size: 80,
                    showPercentage: true,
                  ),
                  const SizedBox(height: 8),
                  const Text('50%'),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NeoProgressRing(
                    progress: 0.75,
                    size: 80,
                    showPercentage: true,
                  ),
                  const SizedBox(height: 8),
                  const Text('75%'),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NeoProgressRing(
                    progress: 1.0,
                    size: 80,
                    showPercentage: true,
                  ),
                  const SizedBox(height: 8),
                  const Text('100%'),
                ],
              ),
            ],
          ),
        ),
        size: const Size(390, 180),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/neo_progress_rings.png'),
      );
    });

    testWidgets('golden - NeoStatBar', (tester) async {
      await _pumpGolden(
        tester,
        Padding(
          padding: const EdgeInsets.all(20),
          child: NeoStatBar.standard(
            streak: 15,
            accuracy: 0.92,
            totalQuestions: 450,
            xp: 1250,
          ),
        ),
        size: const Size(390, 100),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/neo_stat_bar.png'),
      );
    });

    testWidgets('golden - NeoUnitBanner', (tester) async {
      await _pumpGolden(
        tester,
        const Padding(
          padding: EdgeInsets.all(20),
          child: NeoUnitBanner(
            unit: 1,
            part: 7,
            topic: 'JavaScript Closures',
            subtitle: 'Master memory & scope',
          ),
        ),
        size: const Size(390, 140),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/neo_unit_banner.png'),
      );
    });

    testWidgets('golden - NeoProgressButton', (tester) async {
      await _pumpGolden(
        tester,
        Center(
          child: NeoProgressButton(
            progress: 0.75,
            size: 160,
            buttonIcon: Icons.play_arrow,
            buttonLabel: 'START',
            onPressed: () {},
          ),
        ),
        size: Size(390, 280),
      );

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/neo_progress_button.png'),
      );
    });
  });
}
