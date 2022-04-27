import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smiley_ui/smiley_ui.dart';

void main() {
  group('SmileysBottomSheet', () {
    goldenTest(
      'SmileysBottomSheet Golden Tests',
      fileName: 'smileys_bottom_sheet',
      pumpBeforeTest: (tester) async {
        for (int i = 0; i < 10; i++) {
          await tester.pump(const Duration(seconds: 1));
        }
      },
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'default',
            child: const SmileysBottomSheet(),
          ),
          GoldenTestScenario(
            name: 'title: Test',
            child: const SmileysBottomSheet(
              title: 'Test',
            ),
          ),
          GoldenTestScenario(
            name: 'submitButtonText: Test',
            child: const SmileysBottomSheet(
              submitButtonText: 'Test',
            ),
          ),
          GoldenTestScenario(
            name: 'red button',
            child: SmileysBottomSheet(
              submitButtonStyle: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  });
}
