import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class LabeledSlider extends StatelessWidget {
  final int divisions;
  final double min;
  final double max;
  final String label;
  final double value;
  final TextStyle textStyle;
  final InputDecoration decoration;
  final NumberFormat numberFormat;
  final void Function(double) onChanged;

  LabeledSlider({
    Key key,
    this.value,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.divisions,
    this.label,
    this.numberFormat,
    this.textStyle,
    @required this.max,
    @required this.min,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _numberFormat = numberFormat ?? NumberFormat.compact();

    return Column(
      children: [
        InputDecorator(
          decoration: decoration,
          child: Slider(
            key: key,
            label: label,
            divisions: divisions,
            max: max,
            min: min,
            onChanged: onChanged,
            value: value,
          ),
        ),
        Row(
          children: <Widget>[
            const Spacer(),
            Text(
              _numberFormat.format(value),
              style: textStyle,
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
