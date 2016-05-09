import 'package:DartWeb/model/GameObject.dart';
import 'package:DartWeb/model/Enums.dart';

///
/// Wird durch den Spieler Kontrolliert. Ein rechteck am unteren Rand des
/// des Spieles das den Ball reflektiert
///
class Player extends MoveableObject {




  ///
  /// Ändert die Länge des [Player]
  ///
  void changeLength(int length) {
    //TODO: Implement Method
  }

  ///
  /// Ändert den Abstand den der [Player] pro tastendruck zurück legt
  ///
  void changeSpeed(int speed) {

  }

  @override
  bool collisionAhead(Direction direction, List<List<GameObject>> gameField) {
    // TODO: implement collisionAhead
  }

  @override
  void move(Direction direction, List<List<GameObject>> gameField) {
    // TODO: implement move
  }

  Player(int xPosition,int yPosition,int moveSpeed,int width,int length) {
    super();
  }

}