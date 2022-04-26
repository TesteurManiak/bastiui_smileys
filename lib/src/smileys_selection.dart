import 'package:flutter/material.dart';

import 'smiley_expression.dart';
import 'smiley_widget.dart';

const kDefaultSmileyExpressions = <SmileyExpression>[
  SmileyExpression.verySad,
  SmileyExpression.sad,
  SmileyExpression.neutral,
  SmileyExpression.happy,
  SmileyExpression.veryHappy,
];

typedef SmileySelectionCallback = void Function(
  SmileyExpression? smileySelected,
);

class SmileysSelection extends StatefulWidget {
  /// List of smiley expressions to display.
  final List<SmileyExpression> expressions;

  /// Callback called when the user selects or unselect a smiley.
  final SmileySelectionCallback? onSmileySelected;

  /// Create a widget which displays a list of smileys and allows selection.
  const SmileysSelection({
    Key? key,
    this.expressions = kDefaultSmileyExpressions,
    this.onSmileySelected,
  }) : super(key: key);

  @override
  State<SmileysSelection> createState() => _SmileysSelectionState();
}

class _SmileysSelectionState extends State<SmileysSelection> {
  SmileyExpression? _selectedExpression;

  void _onSmileyTapped(SmileyExpression expression) {
    if (_selectedExpression == expression) {
      setState(() => _selectedExpression = null);
    } else {
      setState(() => _selectedExpression = expression);
    }
    widget.onSmileySelected?.call(_selectedExpression);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: kDefaultSmileySize * 1.2),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        children: widget.expressions.map((expression) {
          return SmileyWidget(
            expression: expression,
            isSelected: _selectedExpression == expression,
            isEnabled: _selectedExpression == null,
            onSelected: () => _onSmileyTapped(expression),
          );
        }).toList(),
      ),
    );
  }
}
