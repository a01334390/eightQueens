import 'package:eight_queens/queens.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Eight Queens algorithm', () {

    test('count should be 2 on a 4 piece chessboard', () {
      Future<int> future = QueenResolver().solve(4);
      expect(future,completion(equals(2)));
    });

    test('count should be 92 on a 8 piece chessboard', () {
      Future<int> future = QueenResolver().solve(8);
      expect(future,completion(equals(92)));
    });

    test('placing a queen on the same place as another is not a safe move', () {
      List<List<int>> board = [[1,0,0,0],
                               [0,0,0,0],
                               [0,0,0,0],
                               [0,0,0,0]];
      Future<bool> future = QueenResolver().isSafe(board, 0, 0, 4);
      expect(future,completion(equals(false)));
    });

    test('placing a queen on an empty place is a safe move', () {
      List<List<int>> board = [[0,0,0,0],
                               [0,0,0,0],
                               [0,0,0,0],
                               [0,0,0,0]];
      Future<bool> future = QueenResolver().isSafe(board, 0, 0, 4);
      expect(future,completion(equals(true)));
    });

    test('placing a queen right next to another is not a safe move', () {
      List<List<int>> board = [[1,0,0,0],
                               [0,0,0,0],
                               [0,0,0,0],
                               [0,0,0,0]];
      Future<bool> future = QueenResolver().isSafe(board, 0, 1, 4);
      expect(future,completion(equals(false)));
    });

    test('placing a queen in direct diagonal to another is not a safe move', () {
      List<List<int>> board = [[1,0,0,0],
                               [0,0,0,0],
                               [0,0,0,0],
                               [0,0,0,0]];
      Future<bool> future = QueenResolver().isSafe(board, 1, 1, 4);
      expect(future,completion(equals(false)));
    });

    test('passing a complete board to the solver method returns false', () {
      List<List<int>> board = [[0,0,1,0],
                               [1,0,0,0],
                               [0,0,0,1],
                               [0,1,0,0]];
      Future<bool> future = QueenResolver().solveQueens(board, 4, 4);
      expect(future,completion(equals(false)));
    });

  });
}