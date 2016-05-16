import 'package:DartWeb/src/model/Enums.dart';
import 'package:DartWeb/src/model/Level.dart';
import 'package:DartWeb/src/model/GameObject.dart';
import 'package:DartWeb/src/model/Model.dart';
import 'package:DartWeb/src/controller/GameController.dart';


///
/// Enthält alle objekte die sich momentan im Spiel befinden und stellt
/// Funktionen zu dessen bewegung zu verfügung. Lädt außerdem das Level und
/// deren Inhalt.
/// Für nähere Informationen siehe Dokumentation der Funktionen und Attribute
///
class Game {
  ///
  /// Enthält die angabe für den Positiven [Effect] [longerPLayer] wird zum Start
  /// festgelegt
  ///
  int _incLength;

  ///
  /// Enthält die angabe für den negativen [Effect] [smallerPlayer] wird zum Start
  /// festgelegt
  ///
  int _decLength;

  ///
  /// Enthält die angabe für den negativen [Effect] [slowerPLayer] wird zum Start
  /// festgelegt
  ///
  int _decSpeedPLayer;

  ///
  /// Enthält die angabe für den positiven [Effect] [damageBall] wird zum Start
  /// festgelegt
  ///
  int _incDamageBall;
  ///
  /// In welchem [Level] befinden wir uns
  ///
  int countLevel;

  ///
  /// Die level
  ///
  List<Level> gameFields;

  List<MoveableObject> moveableObjects;

  ///
  /// Bewegt alle Bälle um einen Schritt
  /// [direction] In welche Richtung soll sich der [Ball] bewegen
  ///
  void moveBall(GameController controller) {
    gameFields[countLevel].balls.forEach((ball){
        ball.move(ball.direction,gameFields[countLevel].getGameField(),controller);
      if(ball.yPosition<=0){
        gameFields[countLevel].balls.remove(ball);
      }
    });

  }

  ///
  /// Bewegt alle Items um einen Schritt
  /// [direction] in welche richtung soll es sich bewegen
  ///
  ///
  void moveItem(GameController controller) {
    gameFields[countLevel].items.forEach((item){
    item.move(Direction.down,gameFields[countLevel].getGameField(),controller);
    if(item.yPosition<=0){
      gameFields[countLevel].items.remove(item);
    }
    });
  }

  ///
  /// Bewegt den [Player] in die richtung von [x]
  /// [direction]   Die richtung in die der Spieler sich bewegt
  ///
  void movePLayer(Direction direction,GameController controller) {
    Player player = _getPlayer();
    for(int i=player.moveSpeed;i>0;i--){
      player.move(direction,gameFields[countLevel].getGameField(),controller);
    }

  }

  Player _getPlayer(){
    gameFields[countLevel].player;
  }

  ///
  /// Bereitet das nächste level vor in [Level]
  ///
  void newLevel() {}
  ///
  /// Ließt die Json Config um die darin enthaltenen Level anzulgegen
  ///
  void _readConfig() {}

  ///
  /// Löscht ein [MoveableObject] aus dem Spiel
  ///
  void _removeObject(MoveableObject object) {}

  ///
  /// Setzt alle werte auf den Standard zurück
  ///
  void _resetState() {}
}
