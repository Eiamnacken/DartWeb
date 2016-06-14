part of brickGame;

class View {
  final warningoverlay = html.querySelector("#warningoverlay");

  final title = html.querySelector("#title");

  final level = html.querySelector("#level");

  final gameover = html.querySelector("#gameover");

  final game = html.querySelector("#game");

  final points = html.querySelector("#points");

  final highscore = html.querySelector("#highscore");

  final menuview = html.querySelector("#menuview");

  final gameview = html.querySelector("#gameview");

  final welcome = html.querySelector("#welcome");

  final overlay = html.querySelector("#overlay");

  final back = html.querySelector("#back");

  final help = html.querySelector("#help");

  final vanishedButton = html.querySelector("#button");

  html.HtmlElement get startGameButton => html.querySelector("#startgame");

  html.HtmlElement get startButton => html.querySelector("#start");

  html.HtmlElement get backMenuButton => html.querySelector("#backmenu");

  html.HtmlElement get helpButton => html.querySelector("#howto");

  html.HtmlElement get cancelButton => html.querySelector("#cancelbutton");

  html.HtmlElement get rightButton => html.querySelector("#rightbutton");

  html.HtmlElement get leftButton => html.querySelector("#leftbutton");

  List<List<html.HtmlElement>> gameFields;


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

    gameFields = new List<List<html.HtmlElement>>(field.length);
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

    welcome.style.display = model.gameOver() ? "block" : "none";
    back.style.display = model.gameOver() ? "block" : "none";
    vanishedButton.style.display = model.gameOver() ? "none" : "block";


    level.innerHtml="Level: ${model.countLevel + 1}";
    highscore.innerHtml = model.gameOver() ? generateHighscore(scores) : "";
    points.innerHtml = "Points: ${model.points}";

    // Updates the field
    final field = model.gameFields[model.countLevel].gameField;

    for (int row = 0; row < field.length; row++) {
      for (int col = 0; col < field[row].length; col++) {
        var td = gameFields[row][col];
        td.classes.clear();
        GameObject object = field[row][col];
        td.classes.add(object.toString());
        td = _setWidthAndLength(td,object);
        if(object.itemsBuffer.isNotEmpty){
          object.itemsBuffer.forEach((item) => td.classes.add(item.toString()));
        }
      }
    }
  }

  html.HtmlElement _setWidthAndLength(html.HtmlElement element,GameObject gameObject){
    if(element==null|| gameObject==null) return null;
    var width = gameObject.width;
    if(gameObject is Player){
      width = (gameObject.width/3);
      element.style..setProperty("padding-right","${width}px")
        ..setProperty("padding-left","${width}px")
        ..setProperty("width","${width}px")
        ..setProperty("height","${gameObject.height}px");
    }else{
      element.style..setProperty("width","${width}px")
        ..setProperty("height","${gameObject.height}px")
            ..setProperty("padding-right","0px")
        ..setProperty("padding-left","0px");
    }
    return element;



  }





  closeForm() => overlay.innerHtml = "";

  void warning(String message) {
    html.document
        .querySelector('#warningoverlay')
        .innerHtml = message;
  }

  String generateHighscore(List<Map> scores, { int score: 0 }) {
    final list = scores.map((entry) => "<li>${entry['name']}: ${entry['score']}</li>").join("");
    final points = "You got $score points";
    return "<div id='scorelist'>${ score == 0 ? "" : points }${ list.isEmpty? "" : "<ul>$list</ul>"}</div>";
  }

  void showHighscore(Game model, List<Map> scores) {

    if (overlay.innerHtml != "") return;
    final score = model.points;

    overlay.innerHtml =
    "<div id='highscore'>"
        "   <h1>Highscore</h1>"
        "</div>"
        "<div id='highscorewarning'></div>";

    if (scores.isEmpty || score > scores.last['score'] || scores.length < 10) {
      overlay.appendHtml(
          this.generateHighscore(scores, score: score) +
              "<form id='highscoreform'>"
                  "<input type='text' id='user' placeholder='user'>"
                  "<input type='password' id='password' placeholder='password'>"
                  "<button type='button' id='save'>Save</button>"
                  "<button type='button' id='close' class='discard'>Close</button>"
                  "</form>"
      );
    } else {
      overlay.appendHtml(this.generateHighscore(scores, score: score));
      overlay.appendHtml("<button type='button' id='close' class='discard'>Close</button>");
    }

  }

  /**
   * Gets the user input from the highscore form.
   */
  String get user => (html.document.querySelector('#user') as html.InputElement).value;

  /**
   * Gets the password input from the highscore form.
   */
  String get password => (html.document.querySelector('#password') as html.InputElement).value;

}
