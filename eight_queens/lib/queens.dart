/**
 * Queen Resolver class
 * Solved using algorithm found in: https://www.geeksforgeeks.org/n-queen-problem-using-branch-and-bound/
 */

import "dart:io";

class QueenResolver {

  var count = 0;

  bool isSafe(board, int row, int col, int n) {
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

  bool solveQueens(board, int col, int n) {

    if (col >= n) {
      solution(board);
      count++;
      return true;
    }

    var res = false;
    for(int i = 0; i < n; i++) {
      if(isSafe(board, i, col, n)){
        board[i][col] = 1;
        res = solveQueens(board, col + 1, n);
        board[i][col] = 0;
      }
    }
    return res;
  }
  
  void solution(List<List<int>> board) {
    for(int i = 0; i < board.length; i++) {
      for(int x = 0; x < board[i].length ; x++) {
        if(board[i][x] == null) {
          print(0);
        } else {
          print(board[i][x]);
        }
      }
      print("next-->");
    }
  }


  bool solve(int n) {
    // Create the initial queens board
     List<List<int>> board = new List.generate(n, (_) => new List(n));

    if(solveQueens(board,0,n) == false) {
      print("Solution doesnt exist");
      print("found solutions: "+count.toString());
      return false;
    }
    return true;
  }
}