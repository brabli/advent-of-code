import 'dart:io';
import 'BingoBoard.dart';

List<String> getNumberList() {
  String contents = File('day-4/input.txt').readAsStringSync().trim();
  List<String> fullInput = contents.split('\n');
  String rawNumbers = fullInput[0];

  return rawNumbers.split(',');
}

List getBingoBoardLists() {
  String contents = File('day-4/input.txt').readAsStringSync().trim();
  List<String> fullInput = contents.split('\n');
  fullInput.removeAt(0);
  fullInput.removeAt(0);

  List boards = [];
  List currentBoard = [];
  for (String line in fullInput) {
    if (line != '') {
      currentBoard.add(line.split(' ').where((e) => e != '').toList());
    } else {
      boards.add([...currentBoard]);
      currentBoard.clear();
    }
  }

  return boards;
}

void main() {
  final allBoards = createBingoBoards(getBingoBoardLists());
  final numberList = getNumberList();
  for (String num in numberList) {
    for (BingoBoard board in allBoards) {
      BingoBoard? win = null;
      board.checkNumber(num);
      win = board.checkColsForBingo();
      if (win != null) {
        findAnswer(win, num);
        exit(0);
      }

      win = board.checkRowsForBingo();
      if (win != null) {
        findAnswer(win, num);
        exit(0);
      }
    }
  }
}

void findAnswer(BingoBoard winningBoard, String lastNum) {
  print(int.parse(lastNum) * winningBoard.getSumOfUnmarkedSquares());
}

List<BingoBoard> createBingoBoards(List bingoBoards) {
  List<BingoBoard> allBoards = [];
  for (List board in bingoBoards) {
    BingoBoard bingoBoard = BingoBoard(board);
    allBoards.add(bingoBoard);
  }

  return allBoards;
}
