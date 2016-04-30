
///
/// Enthält alle objekte die sich momentan im Spiel befinden und stellt
/// Funktionen zu dessen bewegung zu verfügung. Lädt außerdem das Level und
/// deren Inhalt
///
class Game{

  ///
  /// Enthält die angabe für den Positiven effekt [longerPLayer] wird zum Start
  /// festgelegt
  ///
  int _incLength;



}

enum Effekt{
  ///
  /// Lässt den [Player] den der Spieler kontrolliert vergößern um einen Faktor
  /// in [Game] [_incLength] angegeben
  ///
  longerPLayer,
  ///
  /// Erhöht den Schaden den der [Ball] am [Brick] zufügt
  ///
  damageBall,
  secondBall,
  slowerPLayer,
  inverPlayer,
  smallerPlayer
}

class Ball{

}


class MoveableObject{

}

class Player extends MoveableObject{

}

class Brick{

}