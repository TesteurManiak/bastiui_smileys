import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smiley_ui/smiley_ui.dart';

void main() {
  group('SmileysSelection', () {
    goldenTest(
      'SmileysSelection Golden Tests',
      fileName: 'smileys_selection',
      pumpBeforeTest: (tester) async {
        for (int i = 0; i < 10; i++) {
          await tester.pump(const Duration(seconds: 1));
        }
      },
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'default render',
            child: const SmileysSelection(),
          ),
          GoldenTestScenario(
            name: 'only sad faces',
            child: const SmileysSelection(
              expressions: [
                SmileyExpression.sad,
                SmileyExpression.verySad,
              ],
            ),
          ),
        ],
      ),
    );
  });
}
