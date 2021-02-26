import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IconText extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Widget widget;
  
  final double iconSize;
  final double fontSize;
  final double paddingBetweenIconAndText;


  IconText(this.iconData, this.text, {
    this.iconSize = 17,
    this.fontSize = 15,
    this.paddingBetweenIconAndText = 10,
    this.widget
  });

  IconText.withWidget(this.iconData, this.widget, {
    this.iconSize = 17,
    this.fontSize = 15,
    this.paddingBetweenIconAndText = 10,
    this.text = "",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(iconData, color: Theme.of(context).accentColor, size: iconSize),
        SizedBox(width: paddingBetweenIconAndText),
        widget ?? Text(text, style: TextStyle(fontSize: fontSize)),
      ],
    );
  }
}
