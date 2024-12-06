import 'package:quantity/quantity.dart';

class BingoBoard {
  List board = [];
  bool beenChecked = false;

  BingoBoard(List board) {
    board.forEach((element) {
      List line = [];
      element.forEach((e) {
        Map square = {'value': e, 'checked': false};
        line.add(square);
      });

      this.board.add(line);
    });
  }

  void checkNumber(String num) {
    this.board.forEach((line) {
      line.forEach((square) {
        if (square['value'] == num) square['checked'] = true;
      });
    });
  }

  BingoBoard? checkRowsForBingo() {
    for (List line in this.board) {
      if (line.every((sq) => sq['checked'])) return this;
    }

    return null;
  }

  BingoBoard? checkColsForBingo() {
    for (int i = 0; i < this.board.length; i++) {
      if (this.board.every((line) => line[i]['checked'])) return this;
    }

    return null;
  }

  int getSumOfUnmarkedSquares() {
    List squares = [for (var sublist in this.board) ...sublist];
    int total = 0;
    for (Map square in squares) {
      if (square['checked'] == false) total += int.parse(square['value']);
    }

    return total;
  }

  bool hasWon() {
    if (this.checkColsForBingo() == null && this.checkRowsForBingo() == null)
      return false;
    this.beenChecked = true;
    return true;
  }

  @override
  String toString() {
    return this.board.toString();
  }
}
