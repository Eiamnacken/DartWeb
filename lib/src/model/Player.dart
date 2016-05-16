import 'package:DartWeb/src/model/Enums.dart';
import 'package:DartWeb/src/model/GameObject.dart';
import 'package:DartWeb/src/controller/GameController.dart';
///
/// Wird durch den Spieler Kontrolliert. Ein rechteck am unteren Rand des
/// des Spieles das den Ball reflektiert
///
class Player extends MoveableObject {


  Player(int xPosition, int yPosition, int width, int length,int moveSpeed) : super(xPosition, yPosition, width, length,moveSpeed);

  ///
  /// Ändert die Länge des [Player]
  ///
  void changeLength(int length) {
    length=length;
  }

  ///
  /// Ändert den Abstand den der [Player] pro tastendruck zurück legt
  ///
  void changeSpeed(int speed) {
    moveSpeed=speed;
  }


  @override
  void move(Direction direction, List<List<GameObject>> gameField,GameController controller) {
    int x = getValuesForDirection(direction)["X"];
    Map response=collisionAhead(direction,gameField,0,x);
    if(!response.keys.first){
      if(response[false]!=null){
        response[false].collision(gameField,this);
      }
      switchObjects(gameField,x);
      xPosition+=x;
      controller.updateView();
    }
  }






  @override
  void collision(Direction direction, List<List<GameObject>> gameField, GameController controller, GameObject collisionObject) {
    return;
  }
}