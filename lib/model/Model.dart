///
/// Objekt das sich von selbst durch den Spielraum bewegt
/// Außerdem fügt es [Brick] schaden zu bei Kontakt
///
class Ball extends MoveableObject {
  ///
  /// Welchen schaden der [Ball] an einem [Brick] zufügt
  ///
  int _damage;

  ///
  /// Ändert den [_damage] den ein [Ball] einem [Brick] zufügt
  ///
  void changeDamage(int damage) {
    //TODO: Implement Method
  }

  ///
  /// Ändert die geschwindigkeit die der [Ball] pro zeiteinheit zurück legt
  ///
  void changeSpeed(int speed) {
    //TODO: Implement Method
  }

  @override
  void collision(Direction direction, List<List<GameObject>> gameField) {
    // TODO: implement collision
  }
  ///
  /// Wird nur von [move()] angesprochen
  ///
  /// Ändert die richtung in die der Ball fliegt
  ///
  void _changeDirection(Direction direction){
    //TODO: Implement Method
  }
}

///
/// Sind kleine rechtecke die auf dem Spielfeld platziert werden
/// Es ist Ziel des Spieles diese zu zerstören
///
class Brick {
  ///
  /// Gibt an ob dieser [Brick] ein Item enthält welches nach dem [destroy] freigelassen
  /// wird
  ///
  bool _containsItem;

  ///
  /// Größe der [Brick]
  ///
  int _size;

  ///
  /// Position auf der x-Achse zeigt auf den Mittelpunkt
  ///
  int _xPosition;

  ///
  /// Position auf der y-Achse zeigt auf den Mittelpunkt
  ///
  int _yPosition;

  ///
  /// Leben eines [Brick]
  ///
  Health health;

  ///
  /// Verringert die [health] um eine Stufe
  /// Wenn der [Brick] vorher auf [red] stand wird ein `false` zurück gegeben
  /// ansonsten `true`
  ///
  bool decHealth() {
    //TODO: Implement Method
  }

  ///
  /// Zerstört diesen [Brick] und prüft ob es ein [Item] enthält
  /// Gibt ein [Item] zurück wenn es eines enthält ansonsten null
  ///
  Item destroy() {
    //TODO: Implement Method
  }

  ///
  /// Legt ein neues [Item] an und gibt diese zurück
  ///
  Item _release() {
    //TODO: Implement Method
  }
}

///
/// Gibt eine bewegungsrichtung an
///
enum Direction { leftUp, leftDown, rightUp, rightDown, up, down }

///
/// Die art der Effekte
///
enum Effect {
  ///
  /// Lässt den [Player] den der Spieler kontrolliert vergößern um einen Faktor
  /// in [Game] [_incLength] angegeben
  ///
  longerPLayer,

  ///
  /// Erhöht den Schaden den der [Ball] am [Brick] zufügt
  ///
  damageBall,

  ///
  /// Erstellt einen zweiten [Ball]
  ///
  secondBall,

  ///
  /// Verlangsamt die Bewegungsgeschwindigkeit des [Player]
  ///
  slowerPLayer,

  ///
  /// Invertiert die Steuerung des [Player]
  ///
  invertPlayer,

  ///
  /// Verkleinert den [Player] um den Faktor in [_decLength]
  ///
  smallerPlayer
}
///
/// Ein [Level] ist ein Level im Spiel
///
/// Enthält alle [Brick] die zuvor generiert wurden. Diese werden aus der Config
/// generiert die in [_readLevel] übergeben werden vom Constructor
///
class Level {

  ///
  /// Breite des Spielfelds
  ///
  int _width;
  ///
  /// Länge des Spielfelds
  ///
  int _length;
  ///
  /// Anzahl der positiven [Item] die dieses Level enthält
  ///
  int _countPositiveItems;
  ///
  /// Anzahl der negativen [Item] die dieses Level enthält
  ///
  int _countNegativeItems;
  ///
  /// Enthält das gesamte Spielfeld als 2d Liste
  ///
  /// Felder ohne ein relevantes Objekt enthalten einfach nur die Oberklasse
  /// [GameObject] andere Felder haben dementsprechend [Ball],[Brick],[Item]
  /// oder [Player]
  ///
  List<List<GameObject>> gameField;
  ///
  /// Generiert das Level aus der übergebenen [config]
  ///
  void _readLevel(String config){
    //TODO: Implement Method
  }
  ///
  /// Setzt einen [Brick]
  ///
  void _setBrick(){
    //TODO: Implement Method
  }
  ///
  /// Zerstört einen [Brick] an der angegebenen Position
  ///
  /// Kann ein [Item] liefern wenn dieser [Brick] ein Item enthielt
  ///
  Item removeBrick(Brick brick){
    //TODO: Implement Method
  }

}

///
/// Leben eines [Brick] [green] bedeutet noch 3 treffer [yellow] 2 und [red] 1
/// [grey] sind unzerstörbare [Brick]
///
enum Health { green, yellow, red, grey }

///
/// [Item] sind die Positiven oder Negativen effekte die der Player im laufe des
/// Spieles einsammeln kann
///
class Item extends MoveableObject {
  ///
  /// Handelt es sich um ein Negativ[Effect] oder Positiv[Effect]
  ///
  bool _isPositive;

  ///
  /// Um welche art von [Item] handelt es sich
  ///
  Effect effect;

  ///
  /// Gibt an ob es ein Positiv Effekt ist
  ///
  bool isPositive() {
    //TODO: Implement Method
  }

  @override
  void collision(Direction direction, List<List<GameObject>> gameField) {
    // TODO: implement collision
  }
  ///
  /// Wendet die eigenschaften dieses Items auf den Player an
  ///
  void _activateItem(Player player){
    //TODO: Implement Method
  }
}

class GameObject{
  ///
  /// X position des [MoveableObject] auf dem Spielfeld
  /// Zeigt immer den Mittelpunkt des [MoveableObject] an
  ///
  int _xPosition;

  ///
  /// Y position des [MoveableObject] auf dem Spielfeld
  /// Zeigt immer den Mittelpunkt des [MoveableObject] an
  ///
  int _yPosition;

  ///
  /// Die Breite des [MoveableObject]
  ///
  int _width;

  ///
  /// Die Länge des [MoveableObject]
  ///
  int _length;

}

///
/// Objekte die sich im [Level] bewegen können
///
abstract class MoveableObject extends GameObject{
  ///
  /// Wie viel abstand legt ein [MoveableObject] pro zeiteinheit/tastendruck zurück
  ///
  int _moveSpeed;
  ///
  /// Bewegt ein [MoveableObject] in eine Richtung
  /// [direction] gibt an in welche richtung sich das Objekt bewegt
  /// [gameField] gibt die nötigen Informationen für die [collision]
  ///
  void move(Direction direction,List<List<GameObject>> gameField) {
    //TODO: Implement Method
  }
  ///
  /// Kümmert sich um Kollisionen und passt das gamefield an wenn eine entsteht
  ///
  void collision(Direction direction,List<List<GameObject>> gameField);
  ///
  /// Gibt an ob beim nächsten Schritt in diese Richtung eine kollision stattfinden wird
  ///
  bool collisionAhead(Direction direction,List<List<GameObject>> gameField){
    //TODO: Implement Method
    return true;
  }
}

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
    //TODO: Implement Method
  }

  @override
  void collision(Direction direction, List<List<GameObject>> gameField) {
    // TODO: implement collision
  }
}
