import 'package:flutter/material.dart';

import 'smiley_expression.dart';
import 'smileys_selection.dart';

const _kDefaultTitle = 'How was your experience?';
const _kDefaultSubmitText = 'Submit';
const _kDefaultCancelText = 'Cancel';

class SmileysBottomSheet extends StatefulWidget {
  final String? title;
  final String? submitButtonText;
  final String? cancelButtonText;

  const SmileysBottomSheet({
    Key? key,
    this.title,
    this.submitButtonText,
    this.cancelButtonText,
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
    final cancelButtonText = widget.cancelButtonText ?? _kDefaultCancelText;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(title),
          const SizedBox(height: 8),
          SmileysSelection(
            onSmileySelected: (smileySelected) =>
                _selectedExpression.value = smileySelected,
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<SmileyExpression?>(
            valueListenable: _selectedExpression,
            builder: (context, selectedExpression, _) {
              return TextButton(
                onPressed: selectedExpression != null
                    ? () => Navigator.pop(context, selectedExpression)
                    : null,
                child: Text(submitButtonText),
              );
            },
          ),
          TextButton(
            child: Text(cancelButtonText),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

Future<SmileyExpression?> showSmileysBottomSheet(BuildContext context) {
  return showModalBottomSheet<SmileyExpression?>(
    context: context,
    builder: (_) => const SmileysBottomSheet(),
  );
}
