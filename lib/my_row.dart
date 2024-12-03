import 'package:flutter/material.dart';
import 'package:tic_tac_toe/my_button.dart';

class MyRow extends StatelessWidget {
  final List<String> rowLabels;
  final void Function(int, int) onClick;
  final int row;
  final List<Color> btnBg;
  const MyRow(
      {super.key,
      required this.rowLabels,
      required this.onClick,
      required this.row,
      required this.btnBg});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          MyButton(
              column: 0,
              row: row,
              btnBg: btnBg[0],
              btnLabel: rowLabels[0],
              onClick: onClick),
          MyButton(
              column: 1,
              row: row,
              btnBg: btnBg[1],
              btnLabel: rowLabels[1],
              onClick: onClick),
          MyButton(
              column: 2,
              row: row,
              btnBg: btnBg[2],
              btnLabel: rowLabels[2],
              onClick: onClick),
        ],
      ),
    );
  }
}
