///
///Queen Resolver class
///Solved using algorithm found in: https://www.geeksforgeeks.org/n-queen-problem-backtracking-3/
///Adapted for use with Dart and Flutter
///

import 'package:shared_preferences/shared_preferences.dart';

class QueenResolver {

  int count = 0;

  ///
  /// Checks if a queen can be placed on a [board] in a [row] and [col]
  /// Returns a [bool] if it's safe to place it [true] or not [false]
  ///
  Future<bool> isSafe(board, int row, int col, int n) async {
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

  ///
  /// Main eight queens algorithm
  /// Receives a single [board] and [col] positions, as well as [n] queens.
  /// Will return [true] when solved.
  ///
  Future<bool> solveQueens(board, int col, int n) async {

    /* Solve for the base case : All queens are placed
    * Then, store it into local storage */
    if (col >= n) {
      count++;
      storeSolution(board).then((value) {
        return true;
      });
    }

    var res = false;
    /** Consider the [col] and try placing it on the [board] **/
    for(int i = 0; i < n; i++) {
      if(await isSafe(board, i, col, n)){
        board[i][col] = 1;
        res = await solveQueens(board, col + 1, n);
        board[i][col] = 0;
      }
    }
    return res;
  }

  /// Stores a complete [board] into [SharedPreferences]
  /// Because the [board] is not completely initialized, it requires to convert all [null] values to [0].
  /// Stores also the current [count] into [SharedPreferences]
  Future storeSolution(List<List<int>> board) async {
    for(int i = 0; i < board.length; i++) {
      for(int x = 0; x < board[i].length ; x++) {
        if(board[i][x] == null) {
          board[i][x] = 0;
        }
      }
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('board'+count.toString(), board.toString());
    await prefs.setInt('count', count);
  }

  ///
  /// Function entryway to solve for [n] queens.
  /// Will return [count] for the app's purposes
  ///
  Future<int> solve(int n) async {
    // Create the initial queens board
     List<List<int>> board = new List.generate(n, (_) => new List(n));

    if(await solveQueens(board,0,n) == false) {
      return count;
    }
    return count;
  }
}