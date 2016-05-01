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
  void changeDamage(int damage) {}

  ///
  /// Ändert die geschwindigkeit die der [Ball] pro zeiteinheit zurück legt
  ///
  void changeSpeed(int speed) {}
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
  bool decHealth() {}

  ///
  /// Zerstört diesen [Brick] und prüft ob es ein [Item] enthält
  /// Gibt ein [Item] zurück wenn es eines enthält ansonsten null
  ///
  Item destroy() {}

  ///
  /// Legt ein neues [Item] an und gibt diese zurück
  ///
  Item _release() {}
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
/// Ein [GameField] ist ein Level im Spiel
///
/// Enthält alle [Brick] die zuvor generiert wurden. Diese werden aus der Config
/// generiert die in [_readLevel] übergeben werden vom Constructor
///
class GameField {

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
  /// Alle [Brick] die auf dem [GameField] enthalten sind
  ///
  List<Brick> bricks;
  ///
  /// Generiert das Level aus der übergebenen [config]
  ///
  void _readLevel(String config){

  }
  ///
  /// Setzt einen [Brick]
  ///
  void _setBrick(){

  }
  ///
  /// Zerstört einen [Brick] an der angegebenen Position
  ///
  /// Kann ein [Item] liefern wenn dieser [Brick] ein Item enthielt
  ///
  Item removeBrick(Brick brick){

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
  bool isPositive() {}
}

///
/// Objekte die sich im [GameField] bewegen können
///
class MoveableObject {
  ///
  /// Wie viel abstand legt ein [MoveableObject] pro zeiteinheit/tastendruck zurück
  ///
  int _moveSpeed;

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

  ///
  ///
  ///
  void move(int x, int y) {}
}

///
/// Wird durch den Spieler Kontrolliert. Ein rechteck am unteren Rand des
/// des Spieles das den Ball reflektiert
///
class Player extends MoveableObject {
  ///
  /// Ändert die Länge des [Player]
  ///
  void changeLength(int length) {}

  ///
  /// Ändert den Abstand den der [Player] pro tastendruck zurück legt
  ///
  void changeSpeed(int speed) {}
}
