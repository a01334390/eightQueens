/**
 * Queen Resolver class
 * Solved using algorithm found in: https://www.geeksforgeeks.org/n-queen-problem-using-branch-and-bound/
 */
class QueenResolver {

  bool isSafe(int row, int col, List<List<int>> slash, List<List<int>> backslash, List<bool> rowLookup, List<bool> slashCodeLookup, List<bool> backslashCodeLookup) {
    if(slashCodeLookup[slash[row][col]] || backslashCodeLookup[backslash[row][col]] || rowLookup[row]) {
      return false;
    } else {
      return true;
    }
  }

  bool solveQueens(List<List<int>> board, int col, List<List<int>> slash, List<List<int>> backslash, List<bool> rowLookup, List<bool> slashCodeLookup, List<bool> backslashCodeLookup, int n) {
    if (col >= n) {
      return true;
    }

    // Can the queen be placed on the given board?
    for(int i = 0; i < n; i++ ) {
      if(isSafe(i, col, slash, backslash, rowLookup, slashCodeLookup, backslashCodeLookup)) {
        // Place the queen there
        board[i][col] = 1;
        rowLookup[i] = true;
        slashCodeLookup[slash[i][col]] = true;
        backslashCodeLookup[backslash[i][col]] = true;

        // Recur the rest of the queens
        if(solveQueens(board, col + 1, slash, backslash, rowLookup, slashCodeLookup, backslashCodeLookup, n)) {
          return true;
        }

        // If it didnt lead to success, take it off
        board[i][col] = 0;
        rowLookup[i] = false;
        slashCodeLookup[slash[i][col]] = false;
        backslashCodeLookup[backslash[i][col]] = false;
      }
    }

    return false;
  }
  
  void solution(List<List<int>> board) {
    for(int i = 0; i < board.length; i++) {
      for(int x = 0; x < board[i].length; i++) {
        print(board[i][x]);
      }
      print("\n");
    }
  }


  bool solve(int n) {
    // Create the initial queens board
    var List<List<int>> board = new List();

    // Create helper matrixes
    var List<List<int>> slash = new List();
    var List<List<int>> backslash = new List();

    //Array to tell us which column is occupied
    var rowLookup = new List<bool>.filled(8, false);

    // Create an array to tell us which diagonal are occupied
    var slashCodeLookup = new List<bool>.filled(2*n-1, false);
    var backslashCodeLookup = new List<bool>.filled(2*n-1, false);

    // Initialize the helper matrixes
    for(int i = 0; i < n; i++) {
      for (int x = 0; x < n; x++) {
        slash[i][x] = i + x;
        backslash[i][x] = i - x + 7;
      }
    }
    
    if(solveQueens(board, 0, slash, backslash, rowLookup, slashCodeLookup, backslashCodeLookup, n) == false) {
      print("Solution doesnt exist");
      return false;
    }
    
    solution(board);
    return true;
  }
}