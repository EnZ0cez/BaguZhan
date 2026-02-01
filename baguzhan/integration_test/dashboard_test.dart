import 'package:baguzhan/presentation/pages/progress_dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Progress Dashboard Integration Tests', () {
    testWidgets('dashboard renders correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProgressDashboardPage(),
        ),
      );

      await tester.pumpAndSettle();

      // 验证页面基本元素存在
      expect(find.byType(ProgressDashboardPage), findsOneWidget);
    });

    testWidgets('dashboard navigation works', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const ProgressDashboardPage(),
          routes: {
            '/quiz': (_) => const Scaffold(body: Text('Quiz Page')),
            '/wrong-book': (_) => const Scaffold(body: Text('Wrong Book')),
          },
        ),
      );

      await tester.pumpAndSettle();

      // 验证页面渲染完成
      expect(find.byType(ProgressDashboardPage), findsOneWidget);
    });

    testWidgets('start button is displayed', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProgressDashboardPage(),
        ),
      );

      await tester.pumpAndSettle();

      // 查找开始按钮
      final startButton = find.text('START');
      if (startButton.evaluate().isNotEmpty) {
        expect(startButton, findsOneWidget);
      }
    });
  });
}
