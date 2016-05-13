
import 'package:DartWeb/src/model/Enums.dart';
import 'package:DartWeb/src/controller/GameController.dart';

abstract class GameObject{
  ///
  /// X position des [MoveableObject] auf dem Spielfeld
  /// Zeigt immer den Mittelpunkt des [MoveableObject] an
  ///
  int xPosition;

  ///
  /// Y position des [MoveableObject] auf dem Spielfeld
  /// Zeigt immer den Mittelpunkt des [MoveableObject] an
  ///
  int yPosition;

  ///
  /// Die Breite des [MoveableObject]
  ///
  int width;

  ///
  /// Die Länge des [MoveableObject]
  ///
  int length;

  GameObject(this.xPosition, this.yPosition, this.width, this.length);


}

///
/// Objekte die sich im [Level] bewegen können
///
abstract class MoveableObject extends GameObject{
  ///
  /// Wie viel abstand legt ein [MoveableObject] pro zeiteinheit/tastendruck zurück
  ///
  int moveSpeed;

  MoveableObject(int xPosition, int yPosition, int width, int length,this.moveSpeed): super(xPosition, yPosition, width, length);

  ///
  /// Bewegt ein [MoveableObject] in eine Richtung
  /// [direction] gibt an in welche richtung sich das Objekt bewegt
  /// [gameField] gibt die nötigen Informationen für die [collision]
  ///
  void move(Direction direction,List<List<GameObject>> gameField,GameController controller);

  ///
  /// Gibt an ob beim nächsten Schritt in diese Richtung eine kollision stattfinden wird
  ///
  bool collisionAhead(Direction direction,List<List<GameObject>> gameField,int x,[GameController controller,int y]);

  ///
  /// Tauscht den platz zwei [GameObject] im [gameField]
  ///
  /// Diese Methode braucht überarbeitung für flüssige bewegungen
  /// [x] momentane Position des Objekts mit dem dieses Objekt die position tauscht
  /// [y] Dito
  ///
  ///
  void switchObjects(List<List<GameObject>> gameField, x,y){
    MoveableObject buffer = gameField[xPosition][yPosition];
    gameField[xPosition][yPosition]= null;
    gameField[x][y]=buffer;
  }




}


