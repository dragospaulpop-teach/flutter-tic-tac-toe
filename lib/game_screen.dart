import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app_bar.dart';
import 'package:tic_tac_toe/app_drawer.dart';
import 'package:tic_tac_toe/my_row.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
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
    return Scaffold(
      appBar: const CustomAppBar(title: 'TIC TAC TOE URA 2024 - GAME'),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Text(
            "Current player : $currentPlayer",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold // Change this to your desired color
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
              child: const Text('Reset')),
          Text("Winner is $winner")
        ],
      ),
    );
  }
}
