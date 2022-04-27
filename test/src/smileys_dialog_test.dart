import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smiley_ui/smiley_ui.dart';

void main() {
  group('SmileysDialog', () {
    goldenTest(
      'SmileysDialog Golden Tests',
      fileName: 'smileys_dialog',
      pumpBeforeTest: (tester) async {
        for (int i = 0; i < 10; i++) {
          await tester.pump(const Duration(seconds: 1));
        }
      },
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'default',
            child: const SmileysDialog(),
          ),
          GoldenTestScenario(
            name: 'title: Test',
            child: const SmileysDialog(
              title: 'Test',
            ),
          ),
          GoldenTestScenario(
            name: 'submitButtonText: Test',
            child: const SmileysDialog(
              submitButtonText: 'Test',
            ),
          ),
          GoldenTestScenario(
            name: 'cancelButtonText: Test',
            child: const SmileysDialog(
              cancelButtonText: 'Test',
            ),
          ),
          GoldenTestScenario(
            name: 'red submit button',
            child: SmileysDialog(
              submitButtonStyle: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.red),
              ),
            ),
          ),
          GoldenTestScenario(
            name: 'red cancel button',
            child: SmileysDialog(
              cancelButtonStyle: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  });
}
