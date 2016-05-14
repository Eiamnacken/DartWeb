///
/// Gibt eine bewegungsrichtung an
///
enum Direction { leftUp, leftDown, rightUp, rightDown, up, down,left,right }


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
/// Leben eines [Brick] [green] bedeutet noch 3 treffer [yellow] 2 und [red] 1
/// [grey] sind unzerstörbare [Brick]
///
enum Health { green, yellow, red, grey }