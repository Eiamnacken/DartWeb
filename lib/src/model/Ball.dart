import 'GameObject.dart';
import 'Enums.dart';
import 'package:DartWeb/src/controller/GameController.dart';
import 'package:DartWeb/src/model/Brick.dart';
import 'package:DartWeb/src/model/Player.dart';

///
/// Objekt das sich von selbst durch den Spielraum bewegt
/// Außerdem fügt es [Brick] schaden zu bei Kontakt
///
class Ball extends MoveableObject {
  ///
  /// Welchen schaden der [Ball] an einem [Brick] zufügt
  ///
  int _damage;

  Direction _direction;

  Ball(int xPosition, int yPosition, int width, int length, int moveSpeed) : super(xPosition, yPosition, width, length, moveSpeed);

  ///
  /// Ändert den [_damage] den ein [Ball] einem [Brick] zufügt
  ///
  void changeDamage(int damage) {
    _damage=damage;
  }

  Direction get direction=> _direction;

  ///
  /// Ändert die geschwindigkeit die der [Ball] pro zeiteinheit zurück legt
  ///
  void changeSpeed(int speed) {
    moveSpeed=speed;
  }

  ///
  /// Wird nur von Objekten aufgerufen die bei ihrer eigenen bewegung mit dem [Ball kolidieren
  ///
  void collision(Direction direction, List<List<GameObject>> gameField,GameController controller) {
    switch(_direction){
      case Direction.leftDown:
        _changeDirection(Direction.leftUp);
        break;
      case Direction.rightDown:
        _changeDirection(Direction.rightUp);
        break;
      default:
        break;
    }

  }
  ///
  /// Wird nur von [move] und [collision] angesprochen
  ///
  /// Ändert die richtung in die der Ball fliegt
  ///
  void _changeDirection(Direction direction){
    _direction=direction;
  }


  //TODO Was passiert wenn der Ball den Spieler trifft vorallem überdenke nochmal move
  @override
  bool collisionAhead(Direction direction, List<List<GameObject>> gameField, int x, [GameController controller,int y]) {
    GameObject buffer = gameField[xPosition+x][yPosition+y];
    if(buffer is Brick){
      buffer.decHealth(_damage,gameField);
      _changeDirection(direction);
      return true;
    }else if(yPosition+y<=gameField[xPosition].length){
      return false;
    }else if(buffer is Player){
      collision(direction,gameField,controller);
      return true;
    }else return false;
  }



  @override
  void move(Direction direction, List<List<GameObject>> gameField, GameController controller) {
    int x=0;
    int y=0;
    switch(direction){
      case Direction.leftUp:
        x=-1;
        y=1;
        break;
      case Direction.leftDown:
        x=-1;
        y=-1;
        break;
      case Direction.rightDown:
        x=1;
        y=-1;
        break;
      case Direction.rightUp:
        x=1;
        y=1;
        break;
      case Direction.up:
        x=0;
        y=1;
        break;
      case Direction.down:
        x=0;
        y=-1;
        break;
      default:
        break;
    }
    if(!collisionAhead(direction,gameField,x,controller,y)){
      xPosition+=x;
      yPosition+=y;
      controller.updateView();
    }else if(yPosition>gameField[0].length){
      move(_direction,gameField,controller);
    }else{
      gameField[xPosition][yPosition]=  null;
    }
  }
}