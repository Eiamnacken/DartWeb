import 'package:DartWeb/src/model/Enums.dart';
import 'package:DartWeb/src/model/GameObject.dart';
import 'package:DartWeb/src/model/Ball.dart';
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
  bool collisionAhead(Direction direction, List<List<GameObject>> gameField,int x,[GameController controller,int y]) {
    MoveableObject nextObject = gameField[xPosition+x][yPosition];
    if(nextObject is Ball){
      nextObject.collision(direction,gameField,controller);
    }if(_hitWall(gameField,x)){
      return true;
    }
    return false;
  }

  ///
  /// Wertet aus ob der Player mit einem zug nach links oder rechts die Wand trifft
  ///
  bool _hitWall(List<List<GameObject>> gameField,int x){
    if(xPosition+x==gameField.length||xPosition+x==0){
      return true;
    }
    return false;
  }

  @override
  void move(Direction direction, List<List<GameObject>> gameField,GameController controller) {
    int x=0;
    int i = moveSpeed;
    switch(direction){
      case Direction.left:
        x=-1;
        break;
      case Direction.right:
        x=1;
        break;
      default:
    }
      while(!collisionAhead(direction,gameField,x,controller)&&i>0){
        switchObjects(gameField,xPosition+x,yPosition);
        xPosition+=x;
        i--;
        controller.updateView();
      }
  }





}