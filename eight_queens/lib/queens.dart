/**
 * Queen Resolver class
 * Solved using algorithm found in: https://www.geeksforgeeks.org/n-queen-problem-using-branch-and-bound/
 */

import "dart:io";

class QueenResolver {

  List<List<List<int>>> boards = new List();

  Future<bool> _isSafe(board, int row, int col, int n) async {
      // Check row on the left side
      for (var i = 0; i < col; i++) {
        if(board[row][i] == 1 && board[row][i] != null) {
          return false;
        }
      }
      // Check row on the upper diagonal
      var i = row;
      var j = col;
      while(i >= 0 && j >= 0 ) {
        if(board[i][j] != null && board[i][j] == 1) {
          return false;
        }
        i -= 1;
        j -= 1;
      }
      // Check lower diagonal
      i = row;
      j = col;
      while(j >= 0 && i < n) {
        if(board[i][j] != null && board[i][j] == 1) {
          return false;
        }
        i += 1;
        j -= 1;
      }

      return true;
  }

  Future<bool> _solveQueens(board, int col, int n) async {

    if (col >= n) {
      _storeSolution(board);
      return true;
    }

    var res = false;
    for(int i = 0; i < n; i++) {
      if(await _isSafe(board, i, col, n)){
        board[i][col] = 1;
        res = await _solveQueens(board, col + 1, n);
        board[i][col] = 0;
      }
    }
    return res;
  }
  
  void _storeSolution(List<List<int>> board) {
    for(int i = 0; i < board.length; i++) {
      for(int x = 0; x < board[i].length ; x++) {
        if(board[i][x] == null) {
          board[i][x] = 0;
        }
      }
    }

    boards.add(board);
  }


  Future<bool> solve(int n) async {
    // Create the initial queens board
     List<List<int>> board = new List.generate(n, (_) => new List(n));

    if(await _solveQueens(board,0,n) == false) {
      print("found solutions: "+boards.length.toString());
      return false;
    }
    return true;
  }
}