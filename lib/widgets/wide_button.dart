import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  const WideButton(this.text,
      {Key? key,
      required,
      this.padding = 0.0,
      this.height = 45,
      required this.onPressed,
      required this.backgroundcolor})
      : super(key: key);

  /// Should be inside a column, row or flex widget
  final String text;
  final double padding;
  final double height;
  final Color backgroundcolor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: MediaQuery.of(context).size.width <= 500
          ? MediaQuery.of(context).size.width
          : 350,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(backgroundcolor),
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
      ),
    );
  }
}
