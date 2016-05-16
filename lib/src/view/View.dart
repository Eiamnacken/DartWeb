part of brickGame;

class View {
  final warningoverlay = querySelector("#warningoverlay");

  final title = querySelector("#title");

  final level = querySelector("#level");

  final gameover = querySelector("#gameover");

  final game = querySelector("#game");

  final overlay = querySelector("#overlay");

  HtmlElement get startButton => querySelector("#start");

  HtmlElement get rightButton => querySelector("#rightbutton");

  HtmlElement get leftButton => querySelector("#leftbutton");

  List<List<HtmlElement>> gameFields;

  void generateField(Game model) {
    final field = model.gameFields[model.countLevel].gameField;

    String table = "";
    for (int row = 0; row < field.length; row++) {
      table += "<tr>";
      for (int col = 0; col < field[row].length; col++) {
        final assignment = field[row][col];
        final pos = "field_${row}_${col}";
        table += "<td id='$pos' class='$assignment'></td>";
      }
      table += "</tr>";
    }
    game.innerHtml = table;

    gameFields = new List<List<HtmlElement>>(field.length);
    for (int row = 0; row < field.length; row++) {
      gameFields[row] = [];
      for (int col = 0; col < field[row].length; col++) {
        gameFields[row].add(game.querySelector("#field_${row}_${col}"));
      }
    }
  }

  void update(Game model, {List<Map> scores: const []}) {
    gameover.innerHtml = model.gameOver() ? "Game Over" : "";

    // Updates the field
    final field = model.gameFields[model.countLevel].gameField;

    for (int row = 0; row < field.length; row++) {
      for (int col = 0; col < field[row].length; col++) {
        final td = gameFields[row][col];
        if (td != null) {
          td.classes.clear();
          if (field[row][col] is Brick)
            td.classes.add('brick');
          else if (field[row][col] is Ball)
            td.classes.add('ball');
          else if (field[row][col] is Player) td.classes.add('player');
        }
      }
    }
  }

  closeForm() => overlay.innerHtml = "";

  void warning(String message) {
    document.querySelector('#warningoverlay').innerHtml = message;
  }
}
