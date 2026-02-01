import 'package:baguzhan/core/theme/neo_brutal_theme.dart';
import 'package:baguzhan/presentation/widgets/neo/neo_button.dart';
import 'package:baguzhan/presentation/widgets/neo/neo_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NeoContainer', () {
    testWidgets('renders with default style', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NeoContainer(
              child: Text('Test Content'),
            ),
          ),
        ),
      );

      expect(find.text('Test Content'), findsOneWidget);

      final container = tester.widget<Container>(
        find.byType(Container).first,
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, NeoBrutalTheme.surface);
      expect(decoration.border, isNotNull);
    });

    testWidgets('applies custom color', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NeoContainer(
              color: Colors.red,
              child: Text('Test'),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.byType(Container).first,
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, Colors.red);
    });

    testWidgets('handles tap events', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NeoContainer(
              onTap: () => tapped = true,
              child: const Text('Tap Me'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });
  });

  group('NeoCard', () {
    testWidgets('renders with white background', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NeoCard(
              child: Text('Card Content'),
            ),
          ),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);

      final container = tester.widget<NeoContainer>(find.byType(NeoContainer));
      expect(container.color, NeoBrutalTheme.surface);
    });
  });

  group('NeoButton', () {
    testWidgets('renders primary button', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NeoButton(
              onPressed: () {},
              child: const Text('Click Me'),
            ),
          ),
        ),
      );

      expect(find.text('CLICK ME'), findsOneWidget);
    });

    testWidgets('handles press events', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NeoButton(
              onPressed: () => pressed = true,
              child: const Text('Press'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('PRESS'));
      await tester.pumpAndSettle();

      expect(pressed, isTrue);
    });

    testWidgets('disabled button does not respond to tap', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NeoButton(
              onPressed: null,
              child: const Text('Disabled'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('DISABLED'));
      await tester.pumpAndSettle();

      expect(pressed, isFalse);
    });

    testWidgets('shows loading state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NeoButton(
              onPressed: () {},
              isLoading: true,
              child: const Text('Loading'),
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('different button sizes', (tester) async {
      for (final size in NeoButtonSize.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: NeoButton(
                onPressed: () {},
                size: size,
                child: const Text('Size'),
              ),
            ),
          ),
        );

        expect(find.text('SIZE'), findsOneWidget);
      }
    });

    testWidgets('different button types', (tester) async {
      for (final type in NeoButtonType.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: NeoButton(
                onPressed: () {},
                type: type,
                child: const Text('Type'),
              ),
            ),
          ),
        );

        expect(find.text('TYPE'), findsOneWidget);
      }
    });
  });

  group('NeoTextButton', () {
    testWidgets('renders with uppercase text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NeoTextButton(
              text: 'Submit',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('SUBMIT'), findsOneWidget);
    });
  });
}
