import 'package:flutter/material.dart';

import 'smiley_expression.dart';
import 'smileys_selection.dart';

const _kDefaultTitle = 'How was your experience?';
const _kDefaultSubmitText = 'Submit';

class SmileysBottomSheet extends StatefulWidget {
  /// Title of the bottom sheet.
  ///
  /// By default, the title is `"How was your experience?"`.
  ///
  /// Its [TextStyle] is based on the value of [ThemeData.textTheme.headline6].
  final String? title;

  /// Text that will be used for the submit button.
  ///
  /// By default, the submit button text is `"Submit"`.
  final String? submitButtonText;

  /// [ButtonStyle] used for the submit button.
  final ButtonStyle? submitButtonStyle;

  const SmileysBottomSheet({
    Key? key,
    this.title,
    this.submitButtonText,
    this.submitButtonStyle,
  }) : super(key: key);

  @override
  State<SmileysBottomSheet> createState() => _SmileysBottomSheetState();
}

class _SmileysBottomSheetState extends State<SmileysBottomSheet> {
  final _selectedExpression = ValueNotifier<SmileyExpression?>(null);

  @override
  void dispose() {
    _selectedExpression.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.title ?? _kDefaultTitle;
    final submitButtonText = widget.submitButtonText ?? _kDefaultSubmitText;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(title, style: Theme.of(context).textTheme.headline6),
          ),
          SmileysSelection(
            onSmileySelected: (smileySelected) =>
                _selectedExpression.value = smileySelected,
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<SmileyExpression?>(
            valueListenable: _selectedExpression,
            builder: (context, selectedExpression, _) {
              return TextButton(
                onPressed: selectedExpression != null
                    ? () => Navigator.pop(context, selectedExpression)
                    : null,
                style: widget.submitButtonStyle,
                child: Text(submitButtonText),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Shows a modal bottom sheet that contains a [SmileysBottomSheet].
Future<SmileyExpression?> showSmileysBottomSheet(
  BuildContext context, {
  String? title,
  String? submitButtonText,
}) {
  return showModalBottomSheet<SmileyExpression?>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => SmileysBottomSheet(
      title: title,
      submitButtonText: submitButtonText,
    ),
  );
}
