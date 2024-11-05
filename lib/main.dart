import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<List<String>> cellLabels = [
    ['', '', ''],
    ['', '', ''],
    ['', '', ''],
  ];
  String currentPlayer = "X";
  String winner = '';
  List<List<Color>> btnBg = [
    [Colors.transparent, Colors.transparent, Colors.transparent],
    [Colors.transparent, Colors.transparent, Colors.transparent],
    [Colors.transparent, Colors.transparent, Colors.transparent],
  ];

  void btnClick(int row, int column) {
    setState(() {
      if (cellLabels[row][column] != '') return;
      if (winner != '') return;
      cellLabels[row][column] = currentPlayer;
      if (isWinner(currentPlayer)) {
        winner = currentPlayer;
        return;
      }
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    });
  }

  bool isWinner(String player) {
    if (cellLabels[0][0] == player &&
        cellLabels[0][1] == player &&
        cellLabels[0][2] == player) {
      btnBg[0][0] = Colors.green;
      btnBg[0][1] = Colors.green;
      btnBg[0][2] = Colors.green;
      return true;
    }
    if (cellLabels[1][0] == player &&
        cellLabels[1][1] == player &&
        cellLabels[1][2] == player) {
      btnBg[1][0] = Colors.green;
      btnBg[1][1] = Colors.green;
      btnBg[1][2] = Colors.green;
      return true;
    }
    if (cellLabels[2][0] == player &&
        cellLabels[2][1] == player &&
        cellLabels[2][2] == player) {
      btnBg[2][0] = Colors.green;
      btnBg[2][1] = Colors.green;
      btnBg[2][2] = Colors.green;
      return true;
    }
    if (cellLabels[0][0] == player &&
        cellLabels[1][0] == player &&
        cellLabels[2][0] == player) {
      btnBg[0][0] = Colors.green;
      btnBg[1][0] = Colors.green;
      btnBg[2][0] = Colors.green;
      return true;
    }
    if (cellLabels[0][1] == player &&
        cellLabels[1][1] == player &&
        cellLabels[2][1] == player) {
      btnBg[0][1] = Colors.green;
      btnBg[1][1] = Colors.green;
      btnBg[2][1] = Colors.green;
      return true;
    }
    if (cellLabels[0][2] == player &&
        cellLabels[1][2] == player &&
        cellLabels[2][2] == player) {
      btnBg[0][2] = Colors.green;
      btnBg[1][2] = Colors.green;
      btnBg[2][2] = Colors.green;
      return true;
    }
    if (cellLabels[0][0] == player &&
        cellLabels[1][1] == player &&
        cellLabels[2][2] == player) {
      btnBg[0][0] = Colors.green;
      btnBg[1][1] = Colors.green;
      btnBg[2][2] = Colors.green;
      return true;
    }
    if (cellLabels[0][2] == player &&
        cellLabels[1][1] == player &&
        cellLabels[2][0] == player) {
      btnBg[0][2] = Colors.green;
      btnBg[1][1] = Colors.green;
      btnBg[2][0] = Colors.green;
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Text(
              "Current player : $currentPlayer",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight:
                      FontWeight.bold // Change this to your desired color
                  ),
            ),
            MyRow(
                row: 0,
                btnBg: btnBg[0],
                rowLabels: cellLabels[0],
                onClick: btnClick),
            MyRow(
                row: 1,
                btnBg: btnBg[1],
                rowLabels: cellLabels[1],
                onClick: btnClick),
            MyRow(
                row: 2,
                btnBg: btnBg[2],
                rowLabels: cellLabels[2],
                onClick: btnClick),
            TextButton(
                onPressed: () {
                  setState(() {
                    winner = '';
                    cellLabels = [
                      ['', '', ''],
                      ['', '', ''],
                      ['', '', ''],
                    ];
                    btnBg = [
                      [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.transparent
                      ],
                      [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.transparent
                      ],
                      [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.transparent
                      ],
                    ];
                  });
                },
                child: Text('Reset')),
            Text("Winner is $winner")
          ],
        ),
      ),
    );
  }
}

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
