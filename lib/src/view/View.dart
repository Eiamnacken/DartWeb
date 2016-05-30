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
    final List<List<GameObject>> field = model.gameFields[model.countLevel]
        .gameField;

    String table = "";

    for (int row = 0; row < field[0].length; row++) {
      table += "<tr>";
      for (int col = 0; col < field.length; col++) {
        final assignment = field[col][row].toString();
        final pos = "field_${col}_${row}";
        table +=
        "<td id='$pos' class='$assignment'  ></td>";
      }
      table += "</tr>";
    }
    game.innerHtml = table;

    gameFields = new List<List<HtmlElement>>(field.length);
    for (int row = 0; row < field.length; row++) {
      gameFields[row] = [];
      for (int col = 0; col < field[row].length; col++) {
        gameFields[row].add(game.querySelector("#field_${row}_${col}"));
        _setWidthAndLength(gameFields[row][col],field[row][col]);

      }
    }
  }

  void update(Game model, {List<Map> scores: const []}) {
    gameover.innerHtml = model.gameOver() ? "Game Over" : "";

    // Updates the field
    final field = model.gameFields[model.countLevel].gameField;

    for (int row = 0; row < field.length; row++) {
      for (int col = 0; col < field[row].length; col++) {
        var td = gameFields[row][col];
        td.classes.clear();
        GameObject object = field[row][col];
        td.classes.add(object.toString());
        td = _setWidthAndLength(td,object);

      }
    }
  }

  HtmlElement _setWidthAndLength(HtmlElement element,GameObject gameObject){
    if(element==null) return null;
    var width = (gameObject.width/3);
    print(width);
    element.style..setProperty("width","${width}px")
    ..setProperty("height","${gameObject.height}px")
    ..setProperty("padding-right","${width}px")
    ..setProperty("padding-left","${width}px");
    if(gameObject is Player) print(gameObject.width);

  }

  closeForm() => overlay.innerHtml = "";

  void warning(String message) {
    document
        .querySelector('#warningoverlay')
        .innerHtml = message;
  }
}
