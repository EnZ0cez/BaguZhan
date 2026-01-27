import 'package:baguzhan/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('complete flow from home to result', (tester) async {
    await tester.pumpWidget(const BaguzhanApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('JavaScript'));
    await tester.pumpAndSettle();

    for (var i = 0; i < 8; i += 1) {
      await tester.tap(find.text('A').first);
      await tester.pump();
      await tester.tap(find.text('提交答案'));
      await tester.pump();
      if (i == 7) {
        await tester.tap(find.text('查看结果'));
      } else {
        await tester.tap(find.text('下一题'));
      }
      await tester.pumpAndSettle();
    }

    expect(find.text('答题结果'), findsOneWidget);
    expect(find.text('总题数'), findsOneWidget);
  });
}
