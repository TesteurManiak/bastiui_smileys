import 'package:flutter/material.dart';

import 'smiley_expression.dart';
import 'smileys_selection.dart';

const _kDefaultTitle = 'How was your experience?';
const _kDefaultSubmitText = 'Submit';
const _kDefaultCancelText = 'Cancel';

class SmileysDialog extends StatefulWidget {
  final String? title;
  final String? submitButtonText;
  final String? cancelButtonText;
  final ButtonStyle? submitButtonStyle;
  final ButtonStyle? cancelButtonStyle;

  const SmileysDialog({
    Key? key,
    this.title,
    this.submitButtonText,
    this.cancelButtonText,
    this.submitButtonStyle,
    this.cancelButtonStyle,
  }) : super(key: key);

  @override
  State<SmileysDialog> createState() => _SmileysDialogState();
}

class _SmileysDialogState extends State<SmileysDialog> {
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

    return AlertDialog(
      title: Text(title),
      content: SmileysSelection(
        expressions: kDefaultSmileyExpressions,
        onSmileySelected: (smileySelected) =>
            _selectedExpression.value = smileySelected,
      ),
      actions: <Widget>[
        TextButton(
          style: widget.cancelButtonStyle,
          onPressed: () => Navigator.pop(context),
          child: Text(cancelButtonText),
        ),
        ValueListenableBuilder<SmileyExpression?>(
          valueListenable: _selectedExpression,
          builder: (context, selectedExpression, _) {
            return ElevatedButton(
              style: widget.submitButtonStyle,
              onPressed: selectedExpression != null
                  ? () => Navigator.pop(context, selectedExpression)
                  : null,
              child: Text(submitButtonText),
            );
          },
        ),
      ],
    );
  }
}

Future<SmileyExpression?> showSmileysDialog(
  BuildContext context, {
  String? title,
  String? submitButtonText,
  String? cancelButtonText,
  ButtonStyle? submitButtonStyle,
  ButtonStyle? cancelButtonStyle,
}) {
  return showDialog<SmileyExpression?>(
    context: context,
    builder: (_) => SmileysDialog(
      title: title,
      submitButtonText: submitButtonText,
      cancelButtonText: cancelButtonText,
      submitButtonStyle: submitButtonStyle,
      cancelButtonStyle: cancelButtonStyle,
    ),
  );
}
