import 'package:flutter/material.dart';

class GameBoard extends StatefulWidget {
  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  List<String> _gameBoard = List.filled(9, '');
  String _currentPlayer = 'X';
  String _winner = '';
  bool _gameOver = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            _gameOver ? 'Winner: $_winner' : 'Current Player: $_currentPlayer',
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(16.0),
          itemCount: 9,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => _playGame(index),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Text(
                    _gameBoard[index],
                    style: TextStyle(fontSize: 64.0),
                  ),
                ),
              ),
            );
          },
        ),
        Visibility(
          visible: _gameOver,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _gameBoard = List.filled(9, '');
                _currentPlayer = 'X';
                _winner = '';
                _gameOver = false;
              });
            },
            child: Text('Play Again'),
          ),
        ),
      ],
    );
  }

  void _playGame(int index) {
    if (_gameBoard[index] == '') {
      setState(() {
        _gameBoard[index] = _currentPlayer;

        if (_checkForWinner()) {
          _winner = _currentPlayer;
          _gameOver = true;
        } else if (_checkForDraw()) {
          _gameOver = true;
        } else {
          _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  bool _checkForWinner() {
    List<List<int>> winningConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var condition in winningConditions) {
      if (_gameBoard[condition[0]] != '' &&
          _gameBoard[condition[0]] == _gameBoard[condition[1]] &&
          _gameBoard[condition[1]] == _gameBoard[condition[2]]) {
        return true;
      }
    }

    return false;
  }

  bool _checkForDraw() {
    for (var cell in _gameBoard) {
      if (cell == '') {
        return false;
      }
    }
    return true;
  }
}
