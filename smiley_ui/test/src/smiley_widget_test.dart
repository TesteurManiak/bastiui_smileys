import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smiley_ui/smiley_ui.dart';

void main() {
  group('SmileyWidget', () {
    goldenTest(
      'SmileyWidget Golden Tests',
      fileName: 'smiley_widget',
      pumpBeforeTest: (tester) async {
        for (int i = 0; i < 10; i++) {
          await tester.pump();
        }
      },
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'verySad',
            child: const SmileyWidget(
              expression: SmileyExpression.verySad,
            ),
          ),
          GoldenTestScenario(
            name: 'sad',
            child: const SmileyWidget(
              expression: SmileyExpression.sad,
            ),
          ),
          GoldenTestScenario(
            name: 'neutral',
            child: const SmileyWidget(
              expression: SmileyExpression.neutral,
            ),
          ),
          GoldenTestScenario(
            name: 'happy',
            child: const SmileyWidget(
              expression: SmileyExpression.happy,
            ),
          ),
          GoldenTestScenario(
            name: 'veryHappy',
            child: const SmileyWidget(
              expression: SmileyExpression.veryHappy,
            ),
          ),
          GoldenTestScenario(
            name: 'veryHappy - selected',
            child: const SmileyWidget(
              expression: SmileyExpression.veryHappy,
              isSelected: true,
            ),
          ),
          GoldenTestScenario(
            name: 'veryHappy - disabled',
            child: const SmileyWidget(
              expression: SmileyExpression.veryHappy,
              isEnabled: false,
            ),
          ),
        ],
      ),
    );
  });
}
