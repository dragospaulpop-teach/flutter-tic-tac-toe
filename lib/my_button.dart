import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String btnLabel;
  final void Function(int, int) onClick;
  final int row;
  final int column;
  final Color btnBg;

  const MyButton(
      {super.key,
      required this.btnLabel,
      required this.onClick,
      required this.row,
      required this.column,
      required this.btnBg});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(border: Border.all(), color: btnBg),
        child: TextButton(
            onPressed: () => onClick(row, column),
            child: Text(
              btnLabel,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: btnLabel == 'X'
                        ? Colors.blue
                        : Colors.red, // Change this to your desired color
                  ),
            )),
      ),
    );
  }
}
